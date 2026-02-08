%% ==============================================================
%  initialisation_MPC.m
%  Parâmetros do micro-rede  +  criação do objeto MPC (mpcobj)
%  ==============================================================

%% 1 ▪ PARÂMETROS DA REDE
f_nom = 50;                  w_nom = 2*pi*f_nom;

Rc = 0.125;  Lc = 0.0013;
Lg = 0.00025; Rg = 0.004778;

V_nom = 230;  U_nom = 400;

Pref = 8.5e4;                % 85 kW
Pc1  = Pref;  Pc2 = 0.5*Pc1;

%% 2 ▪ BARRAMENTO CC / INVERSOR
udc      = 1200
;
Pbat_max = 5e4;              % ±50 kW
Ebat_nom = 200;              % Wh

Kd = 0.04;  Tf = 0.1;  Ki = Kd/Tf;

etac = 0.98;  etab = 1;  eta = etac*etab;

%% 3 ▪ CORRETOR DE CORRENTE
Tr = 0.01;  w = 5/Tr;  ksi = 0.7;
ki = w*w*Lc;  kp = (2*ksi*ki/w) - Rc;

%% 4 ▪ GERADOR (referência)
Pg_nom = 1.28e5;   H_MS = 0.5;
J = 2*H_MS*Pg_nom / w_nom^2;

R = 0.04;  Te = 0.03;  Td = 0.78;  Tn = 0.15;
K1 = 1/Td;  K2 = Tn/Td;  K3 = 1-K2;

%% 5 ▪ FONTE PV e CARGA
Ppv_nom = 4.25e4;   Pl_max = 8.5e4;

%% 6 ▪ MODELO CONTÍNUO E DISCRETO
H_eq = H_MS / f_nom;

A = 0;
B = [ 1/(2*H_eq),  -1/(2*H_eq),  1/(2*H_eq) ];   % [Pbat  Pload  Ppv]
C = 1;  D = 0;

sys      = ss(A,B,C,D);
Ts_disc  = 1;               
sys_disc = c2d(sys,Ts_disc);

%% 7 ▪ OBJETO MPC (para bloco MPC Controller)
Ts_ctrl = 1;                               % controlador a cada 1 s

% classificar sinais: 1-ª coluna = MV (Pbat), colunas 2-3 = MD (Pload, Ppv)
plant   = c2d(sys,Ts_ctrl);
%plant   = ss(A,B,C,D,Ts_ctrl);
plant   = setmpcsignals(plant,'MV',1,'MD',[2 3]);

mpcobj  = mpc(plant,Ts_ctrl);

mpcobj.PredictionHorizon = 360;            % 6 min
mpcobj.ControlHorizon    = 20;

% limites apenas da MV (Pbat)
mpcobj.MV(1).Min      = -Pbat_max;
mpcobj.MV(1).Max      =  Pbat_max;
mpcobj.MV(1).RateMin  = -5e3;
mpcobj.MV(1).RateMax  =  5e3;

% pesos
mpcobj.Weights.OV      = 100;
mpcobj.Weights.MV      = 0.1;
mpcobj.Weights.MVRate  = 1;

disp('initialisation_MPC concluído: mpcobj criado e pronto.');
