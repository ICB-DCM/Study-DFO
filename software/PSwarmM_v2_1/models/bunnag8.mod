#
# D. Bunnag and M. Sun, "Genetic algorithm for constrained global optimization in continuous variables",
# Applied Mathematics and Computation, 171 (2005) 604-636
#
# Problem 10
#

var x{1..20}, >=0, <=100;

minimize fx:
    -0.5*sum{i in 1..20} ((x[i]-2)^2);

subject to con1:
    -3*x[1]+7*x[2]-5*x[4]+x[5]+x[6]+2*x[8]-x[9]-x[10]-9*x[11]+3*x[12]+5*x[13]+x[16]+7*x[17]-7*x[18]-4*x[19]-6*x[20]<=-5;

subject to con2:
    7*x[1]-5*x[3]+x[4]+x[5]+2*x[7]-x[8]-x[9]-9*x[10]+3*x[11]+5*x[12]+x[15]+7*x[16]-7*x[17]-4*x[18]-6*x[19]-3*x[20]<=2;

subject to con3:
    -5*x[2]+x[3]+x[4]+2*x[6]-x[7]-x[8]-9*x[9]+3*x[10]+5*x[11]+x[14]+7*x[15]-7*x[16]-4*x[17]-6*x[18]-3*x[19]+7*x[20]<=-1;

subject to con4:
    -5*x[1]+x[2]+x[3]+2*x[5]-x[6]-x[7]-9*x[8]+3*x[9]+5*x[10]+x[13]+7*x[14]-7*x[15]-4*x[16]-6*x[17]-3*x[18]+7*x[19]<=-3;

subject to con5:
    x[1]+x[2]+2*x[4]-x[5]-x[6]-9*x[7]+3*x[8]+5*x[9]+x[12]+7*x[13]-7*x[14]-4*x[15]-6*x[16]-3*x[17]+7*x[18]-5*x[20]<=5;

subject to con6:
    x[1]+2*x[3]-x[4]-x[5]-9*x[6]+3*x[7]+5*x[8]+x[11]+7*x[12]-7*x[13]-4*x[14]-6*x[15]-3*x[16]+7*x[17]-5*x[19]+x[20]<=4;
    
subject to con7:
    2*x[2]-x[3]-x[4]-9*x[5]+3*x[6]+5*x[7]+x[10]+7*x[11]-7*x[12]-4*x[13]-6*x[14]-3*x[15]+7*x[16]-5*x[18]+x[19]+x[20]<=-1;
    
subject to con8:
    2*x[1]-x[2]-x[3]-9*x[4]+3*x[5]+5*x[6]+x[9]+7*x[10]-7*x[11]-4*x[12]-6*x[13]-3*x[14]+7*x[15]-5*x[17]+x[18]+x[19]<=0;

subject to con9:
    -x[1]-x[2]-9*x[3]+3*x[4]+5*x[5]+x[8]+7*x[9]-7*x[10]-4*x[11]-6*x[12]-3*x[13]+7*x[14]-5*x[16]+x[17]+x[18]+2*x[20]<=9;
    
subject to con10:
    sum{i in 1..20} (x[i])<=40;

data;


# solution (0, 0, 28.8024, 0, 0, 4.1792, 0, 0, 0, 0, 0, 0, 0, 0,0.6188, 4.0933, 0, 2,3064, 0, 0) f=-394.7506

