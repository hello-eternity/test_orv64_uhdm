// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package cache_func;
  import pygmy_cfg::*;
  import pygmy_typedef::*;

  function automatic logic find_empty_way( // {{{
    input   logic [N_WAY-1:0] way_valid,
    input   logic [N_WAY-1:0] way_enable,
    output  way_id_t          empty_way_id
  );
    logic has_empty_way;

    has_empty_way = '0;
    empty_way_id = '0;
    for (int i=0; i<N_WAY; i++) begin
      if (~way_valid[i] & way_enable[i]) begin
        has_empty_way = '1;
        empty_way_id = i;
        break;
      end
    end

    return has_empty_way;
  endfunction // }}}

  function automatic lru_t get_lru_mask(logic [N_WAY-1:0] way_enable); // {{{
    lru_t mask;

    mask = '0;
    mask[0] = ~&way_enable[1:0]; // 1: way 0 or 1 is disabled
    mask[1] = ~&way_enable[3:2]; // 1: way 2 or 3 is disabled
    mask[2] = ~&way_enable[5:4]; // 1: way 4 or 5 is disabled
    mask[3] = ~&way_enable[7:6]; // 1: way 6 or 7 is disabled

    mask[4] = &mask[1:0]; // 1: way 0-3 are disabled
    mask[5] = &mask[3:2]; // 1: way 4-7 are disabled

//     assert (~(mask[4] & mask[5])) else $fatal($sformatf("%m: all ways are disabled way_enable=%b mask=%b", way_enable, mask));

    return mask;
  endfunction // }}}

  function automatic way_id_t get_replace_way_id( // {{{
    lru_t             lru,
    logic [N_WAY-1:0] way_valid,
    logic [N_WAY-1:0] way_pwr_on
  );
    way_id_t          ret;
    logic [N_WAY-1:0] way_enable;
    logic             has_empty_way;
    way_id_t          empty_way_id;
    lru_t             lru_mask;

    way_enable = '1;
    way_enable &= way_pwr_on;

    // find empty way if there is any
    has_empty_way = find_empty_way(way_valid, way_enable, empty_way_id);

    // lru mask
    lru_mask = get_lru_mask(way_enable);

    if (!has_empty_way) begin
      logic search_left;

      if (lru[6]) begin // if LRU[6]==1, search way 0-3, left
        search_left = '1;
        if (lru_mask[4]) begin // way 0-3 are disabled
          search_left = '0;
        end
      end else begin
        search_left = '0; // search way 4-7, right
        if (lru_mask[5]) begin // way 4-7 are disabled
          search_left = '1;
        end
      end

      if (search_left) begin // search 0-3, left
        search_left = '1; // search 0-1 by default

        if (lru[4]) begin// if LRU[4]==1, search way 0-1, left
          if (lru_mask[0]) begin // way 0-1 disabled
            search_left = '0; // replacement must be in way 2-3;
          end
        end else begin
          search_left = '0; // search way 2-3, right
          if (lru_mask[1]) begin // way 2-3 disabled
            search_left = '1; //  replacement must be in way 0-1
          end
        end

        if (search_left) begin
          ret = (lru[0] & way_enable[0]) ? way_id_t'(0) : way_id_t'(1);
        end else begin
          ret = (lru[1] & way_enable[2]) ? way_id_t'(2) : way_id_t'(3);
        end
      end else begin
        // search 4-7, right
        search_left = '1;

        if (lru[5]) begin // search 5-4, left
          if (lru_mask[2]) begin // way 4-5 disabled
            search_left = '0;
          end
        end else begin
          search_left = '0; // search 6-7, right
          if (lru_mask[3]) begin // way 6-7 disabled
            search_left = '1;
          end
        end

        if (search_left) begin
          ret = (lru[2] & way_enable[2]) ? way_id_t'(4) : way_id_t'(5);
        end else begin
          ret = (lru[3] & way_enable[3]) ? way_id_t'(6) : way_id_t'(7);
        end
      end
    end else begin
      ret = empty_way_id;
    end


    return ret;
  endfunction // }}}

  function automatic lru_t update_lru_bits( // {{{
    lru_t     old_lru,
    way_id_t  way_id
  );
    lru_t new_lru;

    new_lru = old_lru;

    // always flip the root bit
    new_lru[6] = ~old_lru[6];

    // flip the second level
    if (way_id[2])
      new_lru[5] = ~old_lru[5];
    else
      new_lru[4] = ~old_lru[4];

    // flip the leap level
    new_lru[way_id[2:1]] = ~old_lru[way_id[2:1]];

//     $display("update_lru_bits: %m old_lru=%b way_id=%b new_lru=%b", old_lru, way_id, new_lru);

    return new_lru;
  endfunction // }}}

  // service hit under miss to the same cache line in a differet way, but not miss under miss now
  function automatic logic is_mshr_hit(mshr_t mshr, cache_paddr_t paddr, way_id_t way_id, logic hit); // {{{
    logic bank_index_hit;
    bank_index_hit =  (mshr.bank_index == paddr.bank_index) & mshr.valid; // cache miss the same line
    //way_id_hit = (way_id == mshr.way_id) & mshr.valid; // cache hit the same way of a miss: data ram is busy

    if (hit)
      return bank_index_hit & (way_id == mshr.way_id); // cache hit the same way in the same bank_index of a miss
//       return way_id_hit;
    else
      return bank_index_hit;

  endfunction // }}}

  // service miss under miss to the same cache line (same address)
  function automatic logic is_mshr_exact_hit(mshr_t mshr, cache_paddr_t paddr); // {{{
    logic exact_hit;
    exact_hit = mshr.valid & (mshr.bank_index == paddr.bank_index) & (mshr.new_tag == paddr.tag);
    return exact_hit;

  endfunction // }}}

  function automatic logic alloc_free_mshr(
    input   mshr_t [N_MSHR-1:0] mshr_bank,
    input   logic               is_read_req,
    output  mshr_sel_t          mshr_sel,
    output  mshr_id_t           mshr_id
  );
    logic has_free_mshr;
    int i;
    has_free_mshr = '0;
    mshr_sel = '0;
    mshr_id = '0;
    for (i=0; i<N_MSHR; i++) begin
      if (~(mshr_bank[i].valid & is_read_req & mshr_bank[i].rw)) begin // when there is a read request, wait until all the write request has been done (received bresp) to guarantee read-after-write data integrety
        if (~mshr_bank[i].valid) begin
          mshr_sel[i] = '1;
          has_free_mshr = '1;
          break;
        end
      end
    end
    mshr_id = mshr_id_t'(i);

    return has_free_mshr;
  endfunction

endpackage
