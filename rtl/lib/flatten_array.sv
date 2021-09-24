// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef __FLATTEN_ARRAY_SV__
`define __FLATTEN_ARRAY_SV__

module flatten_2d_array
# (
  parameter int D1 = 8,
  parameter int D2 = 4
) (
  input   logic [D1-1:0] [D2-1:0] array_2d,
  output  logic [D1*D2-1:0]       array_1d
);

  always_comb begin
    for (int i=0; i<D1; i++) begin
      for (int j=0; j<D2; j++) begin
        array_1d[i*D2+j] = array_2d[i][j];
      end
    end
  end

endmodule

//==========================================================

module unflatten_2d_array
#(
  parameter int D1 = 8,
  parameter int D2 = 4
) (
  input   logic [D1*D2-1:0]       array_1d,
  output  logic [D1-1:0] [D2-1:0] array_2d
);

  always_comb begin
    for (int i=0; i<D1; i++) begin
      for (int j=0; j<D2; j++) begin
        array_2d[i][j] = array_1d[i*D2+j];
      end
    end
  end

endmodule

//==========================================================

module flatten_3d_array
#(
  parameter int D1 = 8,
  parameter int D2 = 4,
  parameter int D3 = 2
) (
  input   logic [D1-1:0] [D2-1:0] [D3-1:0]  array_3d,
  output  logic [D1*D2*D3-1:0]              array_1d
);

  always_comb begin
    for (int i=0; i<D1; i++) begin
      for (int j=0; j<D2; j++) begin
        for (int k=0; k<D3; k++) begin
          array_1d[i*D2*D3+(j*D3+k)] = array_3d[i][j][k];
        end
      end
    end
  end

endmodule

//==========================================================

module unflatten_3d_array
#(
  parameter int D1 = 8,
  parameter int D2 = 4,
  parameter int D3 = 2
) (
  input   logic [D1*D2*D3-1:0]              array_1d,
  output  logic [D1-1:0] [D2-1:0] [D3-1:0]  array_3d
);

  always_comb begin
    for (int i=0; i<D1; i++) begin
      for (int j=0; j<D2; j++) begin
        for (int k=0; k<D3; k++) begin
          array_3d[i][j][k] = array_1d[i*D2*D3+(j*D3+k)];
        end
      end
    end
  end

endmodule

`endif
