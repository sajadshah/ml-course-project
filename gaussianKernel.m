function sim = gaussianKernel(ZI, ZJ, sigma)
%RBFKERNEL returns a radial basis function kernel between x1 and x2
% Ensure that x1 and x2 are column vectors
    %   sim = gaussianKernel(x1, x2) returns a gaussian kernel between x1 and x2
    %   and returns the value in sim
    x1 = ZI';
    sim = zeros(size(ZJ,1),1);
    for i=1:size(ZJ,1)
        x2 = ZJ(i,:)';
        xny         =   x1-x2;
        Normxny    =   xny'*xny;
        sim(i)         =   exp(-Normxny/(2*sigma^2));
    end

end