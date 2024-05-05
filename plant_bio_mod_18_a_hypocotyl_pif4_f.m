clear all;
a1 = [];
i = 1;
d1 = [];


    
domain = [0 120];

xmax = 120;
xmin = 0;

color = ['g' 'b' 'k' 'red'];


p_b = 10.0;
m_b = 1;
k_r = 0.232;
d_e = 27.2;
p_cl = 1.00;
p_cd = 112;
d_c  = 1.79;
m_c  = 1; 
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
p_gh = 0; 
p_hc = 0.180;

p_f = 450; 
p_fp = 22;
d_f = 0.0009;
k_0 = 10;
p_0 = 25;
k_01 = k_0;
m_f = 1;

%m_p = 0.25;
%p_th = [0.2 0.6 0.6];

d_ec = 0.01;
d_cb = 0;
k_eb = 0;
d_bc = 0;
d_bp = 0;




%Experimental Data

p_t1 = 1.3;   %Threshold [0.2 0.09 0.2 1.3]
m_p = 5.9;      %mutP    [1 0.65 4 5.9]

%p_t1 = 0.6;
%m_c = 0.001;

%p_t1 = 0.6;
%m_c = 50;

i = 0;

% for m_c = [1 0.001 50]
for D = 1:24
 i = i+1;
%initial condition 

tc1 = 0;
tc2 = 0;           
tc3 = 0;               
tc4 = 0;
tc5 = 0;
tc6 = 0;

tc = [tc1 tc2 tc3 tc4 tc5 tc6];

[IVSOL, DVSOL] = ode45(@(t,dp) model_18_a(t,dp,p_b,m_b,k_r,d_e,m_c,p_cl,p_cd,d_c...
    ,m_p,p_p,p_pe,d_p,k_pc,d_pb,p_g,k_g,p_gp,p_ge,p_gb,p_gh,p_hc,p_f,p_fp,d_f,k_0,p_0,D,p_t1,k_01,m_f, ...
    d_ec,d_cb,k_eb,d_bc,d_bp),domain,tc);  
                               
                                        




[Row,Col] = size(DVSOL);

g_end = DVSOL(Row,5);
%subplot (2,3,6);
g_end_data(i) = g_end;
day_length(i) = D;





end



%plot(day_length,g_end_data,'-','Color',[0.9290 0.6940 0.1250],'LineWidth',10)
plot(day_length,g_end_data,'-','Color',[0 0 0],'LineWidth',10)
%end
xlim([1 24])
hold on;


exp_D = [4 8 12 16];
exp_hyp = [7.3538 4.3948 2.68285 2.0395];
exp_dev = [0.668411125 0.406120101 0.277211163 0.190259795];

exp_hyp_mut_pif4 = [5.532076923 2.7465 2.177263158 1.208666667];
exp_hyp_mut_pif4_dev  = [0.74006649 0.361545546 0.372886912 0.184124628];

exp_hyp_oe1_pif4 = [12.2035 7.22295 5.8414 3.5197];
exp_hyp_oe1_pif4_dev = [0.365437409 0.785811647 0.455545179 0.302029469];

%exp_hyp_oe2_pif4 = [12.828375 10.1209 9.8363 6.335];  %OLD LD data
exp_hyp_oe2_pif4_dev = [1.291944162 0.564585745 0.522554367 0.544857312];

exp_hyp_oe2_pif4 = [13.16542857 11.64195 9.8363 6.335];

%exp_hyp_oe2_pif4 = [12.828375 10.1209 9.8363 7.042947368];   %New data

%exp_hyp_oe2_pif4 = [12.828375 10.07135 9.8363 6.335];   %Old LD and SD

%exp_hyp_oe2_pif4 = [12.828375 10.07135 9.8363 7.042947368]; %OLD SD

x=[[day_length]',[g_end_data]'];
%error_wt = [[exp_D]',[exp_hyp]',[exp_dev]'];
error_wt = [[exp_D]',[exp_hyp_oe2_pif4]',[exp_hyp_oe2_pif4_dev]']
%save('pif4_mut_experimental_hypocotyl.txt',"x","-ascii");
save('pif4_OE2_final_hypocotyl_experimental_data.txt',"error_wt","-ascii");
%save('pif4_mut_hypocotyl_without_feedback.txt',"x","-ascii");

%e = errorbar(exp_D,exp_hyp,exp_dev,"o",'LineWidth',20);
e.Marker = '.';
e.MarkerSize = 70;
%e.Color = '#000000';
e.CapSize = 10;
hold on;

%e = errorbar(exp_D,exp_hyp_mut_pif4,exp_hyp_mut_pif4_dev,"o",'LineWidth',20)
e.Marker = '.';
e.MarkerSize = 70;
%e.Color = '#FF0000';
e.CapSize = 10;
hold on;
%e = errorbar(exp_D,exp_hyp_oe1_pif4,exp_hyp_oe1_pif4_dev,"o",'LineWidth',1)
e.Marker = '.';
e.MarkerSize = 70;
%e.Color = '#EDB120';
e.CapSize = 10;
hold on;

e = errorbar(exp_D,exp_hyp_oe2_pif4,exp_hyp_oe2_pif4_dev,"o",'LineWidth',1)
e.Marker = '.';
e.MarkerSize = 70;
%e.Color = '#EDB120';
%e.Color = '#FF0000';
%e.Color = '#000000';
e.Color = '#00FF00';

e.CapSize = 10;
hold on;

% xlim([1 24])
% ylim([0 15])
% xticks([0 8 16 24])
% yticks([0 5 10 15])
% set(gca,'FontSize',60);

txt = ['Hypocotyl Length vs Day Length Graph,Model Code No - 18a, Mut_C - 0.001,1,50 and' ...
    ' threshold value = 0.2,0.8,0.6(p_t_1) and P_s_e_l_f = 25,d_e_c = 0.01'];
%sgtitle('Without Feedback - Blue, With Feedback - Black, HY5 - Non Zero')
%sgtitle(txt);

l = 0;
RSS = 0;
TSS = 0;




%mean = (exp_hyp(1)+exp_hyp(2)+exp_hyp(3)+exp_hyp(4))/4;
%mean = (exp_hyp_mut_pif4(1)+exp_hyp_mut_pif4(2)+exp_hyp_mut_pif4(3)+exp_hyp_mut_pif4(4))/4;
%mean = (exp_hyp_oe1_pif4(1)+exp_hyp_oe1_pif4(2)+exp_hyp_oe1_pif4(3)+exp_hyp_oe1_pif4(4))/4;
mean = (exp_hyp_oe2_pif4(1)+exp_hyp_oe2_pif4(2)+exp_hyp_oe2_pif4(3)+exp_hyp_oe2_pif4(4))/4;
for i = [4 8 12 16]

    l = l+1;
    %RSS = RSS + (g_end_data(i) - exp_hyp(l))^2 
    %RSS = RSS + (g_end_data(i) - exp_hyp_mut_pif4(l))^2 ;
    %RSS = RSS + (g_end_data(i) - exp_hyp_oe1_pif4(l))^2 ;
    RSS = RSS + (g_end_data(i) - exp_hyp_oe2_pif4(l))^2; 


    %TSS = TSS + (exp_hyp(l) - mean)^2
    %TSS = TSS +(exp_hyp_mut_pif4(l)-mean)^2;
    %TSS = TSS +(exp_hyp_oe1_pif4(l)-mean)^2;
    TSS = TSS +(exp_hyp_oe2_pif4(l)-mean)^2
end
R_squared = 1 - RSS/TSS

