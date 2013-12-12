function F = quasi2cheb(F)
%QUASI2CHEB   Convert a quasimatrix to an array-valued CHEBFUN.
%   QUASI2CHEB(F) converts the quasimatrix F to an array-valued CHEBFUN by
%   taking the union of the domains of each of the columns:
%
% See also QUASIMATRIX, QUASI2CHEB, NUM2CELL.

% Copyright 2013 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

if ( numel(F) < 2 )
    % F must already be a quasimatrix!
    return
end

% Unify the breakpoints:
F = restrict(F, get(F, 'domain'));
% Collect each column in a cell:
F = num2cell(F);
% Call HORZCAT to collate the columns:
F = [F{:}];

end