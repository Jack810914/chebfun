% Test file for singfun constructor.

function pass = test_singfun_constructor(pref)

% Get preferences:
if ( nargin < 1 )
    pref = chebfunpref();
end

%%
% Select some random points as sample points
% These random points are in [-1, 1]
seedRNG(7890)
x = -1 + 2*rand(1, 100);
x = sort(x);

%% Test calling syntax when the user provides exponents

% Negative fractional exponents
a = rand();
b = rand();
fh = @(x) sin(x)./((1+x).^a.*(1-x).^b);
f = singfun(fh, [-a, -b], [], [], [], pref);
g = singfun(fh, [-a, -b], {'sing', 'sing'}, [], [], pref);
pass(1) = isequal(f,g);
pass(2) = ~any(f.exponents + [a,b]);
pass(3) = ~any(g.exponents + [a,b]);
pass(4) = norm(feval(fh,x) - feval(f,x), inf) < 1e2*get(f, 'epslevel');

%%
% Positive fractional exponents
a = rand();
b = rand();
fh = @(x) sin(x).*(1+x).^a.*(1-x).^b;
f = singfun(fh, [a, b], [], [], [], pref);
g = singfun(fh, [a, b], {'root', 'root'}, [], [], pref);
pass(5) = isequal(f,g);
pass(6) = ~any(f.exponents - [a,b]);
pass(7) = ~any(g.exponents - [a,b]);
pass(8) = norm(feval(fh,x) - feval(f,x), inf) < 1e1*get(f, 'epslevel');

%%
% Negative integer exponents
a = ceil(10*rand);
b = ceil(10*rand);
fh = @(x) exp(x)./((1+x).^a.*(1-x).^b);
f = singfun(fh, [-a, -b], [], [], [], pref);
g = singfun(fh, [-a, -b], {'pole', 'pole'}, [], [], pref);
pass(9) = isequal(f,g);
pass(10) = ~any(f.exponents + [a,b]);
pass(11) = ~any(g.exponents + [a,b]);
% don't check near end-points
xx = x(20:80);
pass(12) = norm(feval(fh,xx) - feval(f,xx), inf) < 1e2*get(f, 'epslevel');

%% Test Syntax and construction when the user doesn't provide exponents
%
% Negative fractional exponents
a = rand();
b = rand();
fh = @(x) exp(sin(x))./((1+x).^a.*(1-x).^b);
f = singfun(fh);
pass(13) = norm(f.exponents + [a,b], inf) < pref.singPrefs.exponentTol;
pass(14) = norm(feval(fh,x) - feval(f,x), inf) < 1e2*get(f, 'epslevel');

%%
% Positive fractional exponents
a = rand();
b = rand();
fh = @(x) sin(exp(cos(x))).*(1+x).^a.*(1-x).^b;
f = singfun(fh);
pass(15) = norm(f.exponents - [a,b], inf) < pref.singPrefs.exponentTol;
pass(16) = norm(feval(fh,x) - feval(f,x), inf) < 1e1*get(f, 'epslevel');

%%
% Negative integer exponents
a = ceil(5*rand);
b = ceil(5*rand);
fh = @(x) exp(sin(x.^2))./((1+x).^a.*(1-x).^b);
f = singfun(fh);
pass(17) = norm(f.exponents + [a,b], inf) < pref.singPrefs.exponentTol;
xx = x(20:80);
pass(18) = norm(feval(fh,xx) - feval(f,xx), inf) < 1e1*get(f, 'epslevel');

%%
% Construction with smoothfuns:
f = smoothfun.constructor( @(x) sin(x));
s = singfun(f);
pass(19) = iszero(f - s.smoothPart);
s = singfun(f, [-1.5, -1], {'sing', 'sing'} );
pass(20) = iszero(f - s.smoothPart);
pass(21) = norm(s.exponents - [-1.5, -1], inf) < pref.singPrefs.exponentTol;