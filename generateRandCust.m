function RandCust = generateRandCust (dMax,dMin)
    RandCust = sqrt((unifrnd (0.33, 1)*(dMax^2 - dMin^2)));
   % RandCust = sqrt((rand([0 1])*(dMax^2 - dMin^2)));
endfunction
