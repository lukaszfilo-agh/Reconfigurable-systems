clear;

 
% R = 181;
% G = 172;
% B = 55;

% R = 181;
% G = 55;
% B = 172;

R = 55;
G = 181;
B = 172;

% R = 159;
% G = 138;
% B = 133;

R_div = R/255;
G_div = G/255;
B_div = B/255;

sign = 1;
prec_i = 1;
prec_f = 8;
word = sign + prec_i + prec_f;

R_fi = fi(R_div,sign,word,prec_f,'RoundingMethod','Floor'); % value, sign, word, fraction
G_fi = fi(G_div,sign,word,prec_f,'RoundingMethod','Floor');
B_fi = fi(B_div,sign,word,prec_f,'RoundingMethod','Floor');

MAX_FIX = max(R_fi, max(G_fi, B_fi));
MIN_FIX = min(R_fi, min(G_fi, B_fi));

C_FIX = MAX_FIX - MIN_FIX;

G_min_B = G_fi - B_fi;
B_min_R = B_fi - R_fi;
R_min_G = R_fi - G_fi;

V = MAX_FIX;

S = double(C_FIX)/double(V); %jebana kropka
S = fi(S,sign,word,prec_f,'RoundingMethod','Floor');

sign = 1;
prec_i = 0;
prec_f = 8;
word = sign + prec_i + prec_f;

G_min_B = fi(G_min_B,sign,word,prec_f,'RoundingMethod','Floor');
C_FIX = fi(C_FIX,sign,word,prec_f,'RoundingMethod','Floor');

if C_FIX == 0
    H = 0;
elseif MAX_FIX == R_fi
    t = double(G_min_B)/double(C_FIX);
    t = fi(t,sign,word,prec_f,'RoundingMethod','Floor');
    H = fi(60,1,8,0)*t;
elseif MAX_FIX == G_fi
    t = double(B_min_R)/double(C_FIX) ;
    t = fi(t,sign,word,prec_f,'RoundingMethod','Floor');
    H = fi(60,1,8,0)*t;
    H = H + fi(120,1,9,0);
elseif MAX_FIX == B_fi
    t = double(R_min_G)/double(C_FIX);
    t = fi(t,sign,word,prec_f,'RoundingMethod','Floor');
    H = fi(60,1,8,0)*t;
    H = H + fi(240,1,10,0);
end

if H < 0
    H = H + fi(360,1,10,0);
end
H = fi((double(H)/360),0,32,8);

sign = 0;
prec_i = 8;
prec_f = 0;
word = sign + prec_i + prec_f;

H_255 = floor(double(H)*255);
V_255 = floor(double(MAX_FIX)*255);
S_255 = floor(double(S)*255);

H_255_fi = fi(H_255,sign,word,prec_f,'RoundingMethod','Floor');
S_255_fi = fi(S_255,sign,word,prec_f,'RoundingMethod','Floor');
V_255_fi = fi(V_255,sign,word,prec_f,'RoundingMethod','Floor');

bin(H_255_fi)
bin(S_255_fi)
bin(V_255_fi)