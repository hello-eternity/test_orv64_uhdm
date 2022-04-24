`ifndef __PYGMY_FUNC__SV__
`define __PYGMY_FUNC__SV__

package pygmy_func;

  function automatic void lru8_get_replace_way_id ( // {{{
    output  logic [2:0] replace_way_id,
    input   logic [6:0] lru,
    input   logic [7:0] way_valid,
    input   logic [7:0] way_enable
  );

    //------------------------------------------------------
    // find empty way if there is any
    logic has_empty_way;
    logic [6:0] lru_mask;
    lru_mask = '0;
    has_empty_way = '0;

    // for (int i=0; i<8; i++) begin
    //   if (~way_valid[i] & way_enable[i]) begin
    //     has_empty_way = '1;
    //     replace_way_id = i;
    //     break;
    //   end
    // end
    i=0;
    while (!(~way_valid[i] & way_enable[i]) && i<8) begin
      i++;
    end
    if (~way_valid[i] & way_enable[i]) begin
      has_empty_way = '1;
      replace_way_id = i;
    end

    //------------------------------------------------------
    // lru_mask from way_enable

    lru_mask[0] = ~&way_enable[1:0]; // 1: way 0 or 1 is disabled
    lru_mask[1] = ~&way_enable[3:2]; // 1: way 2 or 3 is disabled
    lru_mask[2] = ~&way_enable[5:4]; // 1: way 4 or 5 is disabled
    lru_mask[3] = ~&way_enable[7:6]; // 1: way 6 or 7 is disabled

    lru_mask[4] = &lru_mask[1:0]; // 1: way 0-3 are disabled
    lru_mask[5] = &lru_mask[3:2]; // 1: way 4-7 are disabled

    //------------------------------------------------------
    // search for replace_way_id
    if (~has_empty_way) begin
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
          replace_way_id = (lru[0] & way_enable[0]) ? 3'h0 : 3'h1;
        end else begin
          replace_way_id = (lru[1] & way_enable[2]) ? 3'h2 : 3'h3;
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
          replace_way_id = (lru[2] & way_enable[2]) ? 3'h4 : 3'h5;
        end else begin
          replace_way_id = (lru[3] & way_enable[3]) ? 3'h6 : 3'h7;
        end
      end
    end

    // // for debug print
    // $display("lru8_get_replace_way_id: %m lru=%b way_valid=%b way_enable=%b => has_empty_way=%b lru_mask=%b replace_way_id=%h", lru, way_valid, way_pwr_on, way_enable, has_empty_way, lru_mask, replace_way_id);
  endfunction // }}}

  function automatic void lru8_update_lru( // {{{
    output  logic [6:0] new_lru,
    input   logic [6:0] old_lru,
    input   logic [2:0] way_id
  );
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

    // // for debug print
    // $display("lru8_update_lru: %m old_lru=%b way_id=%b => new_lru=%b", old_lru, way_id, new_lru);
  endfunction // }}}

  function automatic void lru2_get_replace_way_id ( // {{{
    output  logic       replace_way_id,
    input   logic [1:0] lru,
    input   logic [1:0] way_valid,
    input   logic [1:0] way_enable
  );

    //------------------------------------------------------
    // find empty way if there is any
    logic has_empty_way;
    has_empty_way = '0;

    // for (int i=0; i<2; i++) begin
    //   if (~way_valid[i] & way_enable[i]) begin
    //     has_empty_way = '1;
    //     replace_way_id = i;
    //     break;
    //   end
    // end
    i=0;
    while (!(~way_valid[i] & way_enable[i]) && i<2) begin
      i++;
    end
    if (~way_valid[i] & way_enable[i]) begin
      has_empty_way = '1;
      replace_way_id = i;
    end

    if (~has_empty_way) begin
      replace_way_id = lru[0] ? 1'b1: 1'b0;
    end

  endfunction // }}}

  function automatic void lru2_update_lru( // {{{
    output  logic [1:0] new_lru,
    input   logic [1:0] old_lru,
    input   logic way_id
  );

    if (way_id == 1'b0) begin
      new_lru = 2'b01;
    end else begin
      new_lru = 2'b10;
    end

  endfunction // }}}


endpackage

`endif

