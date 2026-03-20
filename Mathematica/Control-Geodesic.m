(* ::Package:: *)

(* ::Input:: *)
(*Z[\[Theta]_,n_]:= (1-\[Theta]^n)/(1-\[Theta])*)


(* ::Input:: *)
(*g[\[Theta]_,n_]:=If[\[Theta] !=1, -(\[Theta]*Derivative[1,0][Z][\[Theta],n]/Z[\[Theta],n])^2+1/Z[\[Theta],n]*(\[Theta]^2*Derivative[2,0][Z][\[Theta],n]+\[Theta]*Derivative[1,0][Z][\[Theta],n]),1/12 *(n^2-1)];*)


(* ::Input:: *)
(*g[\[Theta],n]//FullSimplify*)


(* ::Input:: *)
(*Plot[{Sqrt[g[Exp[-\[Lambda]], 10]],Sqrt[g[Exp[-\[Lambda]],15]],Sqrt[g[Exp[-\[Lambda]],30]]},{\[Lambda], -3,3},PlotRange->All]*)


(* ::Input:: *)
(*geodesicLengths = Table[{n,NIntegrate[Sqrt[g[Exp[-\[Lambda]], n]],{\[Lambda],-3,3},WorkingPrecision->100]},{n,5,50}];*)


(* ::Input:: *)
(*ListPlot[{geodesicLengths, Table[{n,Sqrt[n]},{n,5,50}]}]*)


(* ::Input:: *)
(*Energies = Table[{n,6*NIntegrate[g[Exp[-\[Lambda]], n],{\[Lambda],-3,3},WorkingPrecision->MachinePrecision]},{n,5,50}];*)


(* ::Input:: *)
(*geodesicLengthsSquared = Table[{n, geodesicLengths[[n-4,2]]^2},{n,5,50}];*)


(* ::Input:: *)
(*ListPlot[{geodesicLengthsSquared,Energies},PlotStyle->{Red,Blue}]*)


(* ::Input:: *)
(*geodesicLengthsSquared*)


(* ::Input:: *)
(*Limit[g[\[Theta],n],\[Theta]->1]*)


(* ::Input:: *)
(*g2[x_,n_]:= x/(-1+x)^2-(n^2 x^n)/(-1+x^n)^2;*)


(* ::Input:: *)
(*NIntegrate[Sqrt[g2[Exp[-\[Lambda]],10]],{\[Lambda],-3,3}]*)


(* ::Input:: *)
(*5.65^2/(6*10)*)


(* ::Input:: *)
(*g5 = Table[N[Sqrt[g[Exp[-3+6*i/600],5]]],{i,0,600}];*)


(* ::Input:: *)
(*g15 = Table[N[Sqrt[g[Exp[-3+6*i/600],15]]],{i,0,600}];*)


(* ::Input:: *)
(*g30 = Table[N[Sqrt[g[Exp[-3+6*i/600],30]]],{i,0,600}];*)


(* ::Input:: *)
(*Export["Documents/NonGitCode/ComputationalEntropy/g5.csv", g5]*)


(* ::Input:: *)
(*Export["Documents/NonGitCode/ComputationalEntropy/g15.csv", g15]*)


(* ::Input:: *)
(*Export["Documents/NonGitCode/ComputationalEntropy/g30.csv", g30]*)


(* ::Input:: *)
(*f[x_,n_]:= Log[(1-Exp[-n*x])/(1-Exp[-x])];*)


(* ::Input:: *)
(*Derivative[2,0][f][x,n]//FullSimplify*)


(* ::Input:: *)
(*p[x_,n_]:=Derivative[2,0][f][x,n]*)


(* ::Input:: *)
(*Plot[{p[x,10],g[Exp[-x],10]},{x,-3,3}]*)


(* ::Input:: *)
(*f[x,n]//FullSimplify*)


(* ::Input:: *)
(*f[x_,n_]*)


(* ::Input:: *)
(*g[x,n]//FullSimplify*)


(* ::Input:: *)
(*p[Log[x],n]//FullSimplify*)


(* ::Input:: *)
(*Limit[p[x,n],x->0]*)


(* ::Input:: *)
(*f[Log[x],n]*)
