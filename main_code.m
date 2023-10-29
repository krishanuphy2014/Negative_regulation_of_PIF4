clear all;
a1 = [];
i = 1;
d1 = [];


    
domain = [0 120];

xmax = 120;
xmin = 0;

color = ["#000000" "#FF0000" "#0072BD" "#EDB120"];


p_b = 10.0;
m_b = 1;
k_r = 0.232;
d_e = 27.2;
m_c =  1;
p_cl = 1.00;
p_cd = 112;
d_c  = 1.79;
p_p  = 1;
p_pe = 0.332;
d_p = 4.91;
k_pc = 34.3;
d_pb = 0.313;
p_g = 0.009;
k_g = 0.113;
p_gp = 2.93;
p_ge = 0.465;
p_gb = 10.7;
p_f = 450; 
p_fp = 22;
d_f = 0.0009;
k_0 = 10;
p_0 = 25;
k_01 = 90;
d_ec = 0.01;
 
p_th = [0.2 0.2 0.2 0.2];       %Threshold Value for four genotype









%Experimental Data

exp_D = [8 16];                         %Day legth
exp_hyp = [4.2228 2.269105263];         %Hypocotyle length for wildtype(WT)
exp_dev = [0.278813577 0.238650813];    %standard devation of the experimental measurement of hypocotyl for WT 
 
exp_hyp_mut = [2.64675 1.5195];              %Hypocotyl legth of pif4-101
exp_hyp_mut_dev = [0.250230815 0.221709744]; %standard devation of the experimental measurement of hypocotyl for pif4-101 

exp_hyp_oe1 = [8.164526316 3.3828];          %Hypocotyl legth of PIF4-OE1
exp_hyp_oe1_dev = [0.705548673 0.341386739]; %standard devation of the experimental measurement of hypocotyl for PIF4-OE1  

exp_hyp_oe2 = [10.07135 6.3037];             %Hypocotyl legth of PIF4-OE2
exp_hyp_oe2_dev = [0.820796101 0.544857312]; %standard devation of the experimental measurement of hypocotyl for PIF4-OE2

m=0;
for m_p = [1 0.12 4 8.5]

    p_t1 = p_th(i)
    i = i+1;
    j=0;
for D = 1:24

j = j+1;
%initial condition 

tc1 = 0;   %phyB initial condition
tc2 = 0;   %ELF3 initial condition        
tc3 = 0;   %COP1 initial condition        
tc4 = 0;   %PIF4 initial condition
tc5 = 0;   %Hypocotyl growth initial condition
tc6 = 0;   %GUS activity initial condition

tc = [tc1 tc2 tc3 tc4 tc5 tc6];

[IVSOL, DVSOL] = ode45(@(t,dp) hyp_function(t,dp,p_b,m_b,k_r,d_e,m_c,p_cl,p_cd,d_c...
    ,m_p,p_p,p_pe,d_p,k_pc,d_pb,p_g,k_g,p_gp,p_ge,p_gb,p_f,p_fp,d_f,k_0,p_0,D,p_t1,k_01,...
    d_ec),domain,tc);    
                               




[Row,Col] = size(DVSOL);

g_end = DVSOL(Row,5);

g_end_data(j) = g_end;
day_length(j) = D;



end
m = m+1;
plot(day_length,g_end_data,'-','Color',color(m),'LineWidth',5)
hold on;


end


e = errorbar(exp_D,exp_hyp,exp_dev,"o",'LineWidth',1);
e.Marker = 'o';
e.MarkerSize = 5;
e.Color = "#000000";
e.CapSize = 10;

e = errorbar(exp_D,exp_hyp_mut,exp_hyp_mut_dev,"o",'LineWidth',1);
e.Marker = 'o';
e.MarkerSize = 5;
e.Color = "#FF0000";
e.CapSize = 10;

e = errorbar(exp_D,exp_hyp_oe1,exp_hyp_oe1_dev,"o",'LineWidth',1);
e.Marker = 'o';
e.MarkerSize = 5;
e.Color = "#0072BD";
e.CapSize = 10;

e = errorbar(exp_D,exp_hyp_oe2,exp_hyp_oe2_dev,"o",'LineWidth',1);
e.Marker = 'o';
e.MarkerSize = 5;
e.Color = "#EDB120";
e.CapSize = 10;

xlabel('Day Length(Hour)','Fontsize',14)
ylabel('Growth','Fontsize',14)
xlim([1 24])

txt = ['Hypocotyl Length vs Day Length Graph,Model Code No - 18a, Mutp - 0.12,1,4,8.5 and' ...
    ' threshold value = 0.15(p_t_1) and P_s_e_l_f = 25'];
sgtitle(txt);





