function v = norm(F)
%NORM Frobenius norm of a chebfun2v
%
% V = NORM(F) returns the Frobenius norm of the two/three components, i.e. 
% 
%    V = sqrt(norm(F1).^2 + norm(F2).^2),
%
% or
% 
%    V = sqrt(norm(F1).^2 + norm(F2).^2 + norm(F3).^2) 

% Copyright 2013 by The University of Oxford and The Chebfun Developers.
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information. 

% Empty check: 
if ( isempty( F ) ) 
    v = []; 
    return
end

nF = F.nComponents; 
v = 0; 
for jj = 1:nF 
    v = v + sum2( power( F.components{jj}, 2 ) );
end
v = sqrt(v); 

end