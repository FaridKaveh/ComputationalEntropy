(* ::Package:: *)

(* ::Input:: *)
(*\[Delta] = E^(-3);*)


(* ::Input:: *)
(*chainDist[r_,n_]:= If[r!=1,ProbabilityDistribution[(1-r)/(1-r^n)*r^(n-x),{x,1,n,1}], *)
(*ProbabilityDistribution[1/n,{x,1, n, 1}]];*)


(* ::Input:: *)
(*PDF[chainDist[2/3,10],10]*)


(* ::Input:: *)
(*ResourceFunction["KullbackLeiblerDivergence"][chainDist[1,10], chainDist[2/3,10]]*)


(* ::Input:: *)
(*N[Out[27]]*)


(* ::Input:: *)
(*ResourceFunction["KullbackLeiblerDivergence"][chainDist[3/2,10], chainDist[2/3,10]]*)


(* ::Input:: *)
(*N[Out[32]]*)


(* ::Input:: *)
(*ResourceFunction["KullbackLeiblerDivergence"][chainDist[3/2,10], chainDist[1,10]]+ ResourceFunction["KullbackLeiblerDivergence"][chainDist[1,10], chainDist[2/3,10]]*)


(* ::Input:: *)
(*\[Phi][n_,x_]:= If[x!=1,(x-n*x^n+(n-1)x^(n+1))/((1-x)(1-x^n)), (n-1)/2];*)


(* ::Input:: *)
(*Plot[{\[Phi][10,x]-9/2,\[Phi][5,x]-4/2},{x,0,5}, PlotStyle->{Red, Blue}]*)


(* ::Input:: *)
(*\[Psi][c_, n_, x_]:= \[Phi][n, Exp[-c*x]];*)


(* ::Input:: *)
(*Plot[{\[Psi][-3,10,x],\[Psi][-6,10,x],\[Psi][-9,10,x] },{x,-1,1}, PlotStyle->{Red, Blue, Green}]*)


(* ::Input:: *)
(*upperBarriers = ParallelTable[{n,NSolve[\[Phi][n,x]==3/4*(n-1)&&x>0, x, Reals, WorkingPrecision->100]}, {n,5,80}];*)


(* ::Input:: *)
(*upperBarriers[[All,2]] = Flatten[x /. upperBarriers[[All,2]] ];*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*ListPlot[upperBarriers]*)


(* ::Input:: *)
(*lowerBarriers = ParallelTable[{n,NSolve[\[Phi][n,x]==1/4*(n-1)&&x>0, x, Reals, WorkingPrecision->100]}, {n,5,80}]; *)


(* ::Input:: *)
(*lowerBarriers[[All, 2]] = Flatten[x /. lowerBarriers[[All,2]]];*)


(* ::Input:: *)
(*ListPlot[lowerBarriers]*)


(* ::Input:: *)
(*barrierWidth = upperBarriers;*)


(* ::Input:: *)
(*barrierWidth[[All, 2]] = barrierWidth[[All,2]] - lowerBarriers[[All,2]];*)


(* ::Input:: *)
(*ListPlot[{barrierWidth, Table[{n,1/n^(3/5)}, {n,5,80}],Table[{n,1/n^(1/2)}, {n,5,80}]},PlotStyle->{Red, Blue, Green}]*)


(* ::Input:: *)
(*ListPlot[{barrierWidth, Table[{n,9/n}, {n,5,80}]},PlotStyle->{Red, Blue}]*)


(* ::Input:: *)
(*logBarrierWidth = barrierWidth;*)


(* ::Input:: *)
(*logBarrierWidth[[All,2]] = (Log[upperBarriers[[All,2]]/lowerBarriers[[All,2]]]);*)


(* ::Input:: *)
(*ListPlot[logBarrierWidth]*)


(* ::Input:: *)
(*sqrtIntervalVariation = Table[{n,f[Exp[-3], n, 1-1/Sqrt[n]]-f[Exp[-3], n, 1+1/Sqrt[n]]}, {n,5,50}];*)


(* ::Input:: *)
(*ListPlot[{sqrtIntervalVariation,  Table[{n,9/n}, {n,5,80}]}]*)


(* ::Input:: *)
(*phiPrime[n_,x_] =If[x!=1,Derivative[0,1][\[Phi]][n,x],1/12(n^2-1)]; *)


(* ::Input:: *)
(*Plot[{phiPrime[5,x],phiPrime[10,x],phiPrime[15,x],phiPrime[20,x]},{x,0,5},PlotStyle->{Red,Blue,Green},PlotRange->{Automatic, {0,20}}]*)


(* ::Input:: *)
(*phiPrime[n,x]*)


(* ::Input:: *)
(*peakGradientWidth = ParallelTable[{n,NSolve[phiPrime[n,x]== 1/24*(n^2-1)&&x>0,x]}, {n,5,80}];*)


(* ::Input:: *)
(*peakGradientWidth = peakGradientWidth[[2;;]]*)


(* ::Input:: *)
(*peakGradientWidth[[All,2]]=x/.peakGradientWidth[[All,2]] ;*)


(* ::Input:: *)
(*Do[peakGradientWidth[[i, 2]]= peakGradientWidth[[i, 2]][[2]]- peakGradientWidth[[i, 2]][[1]],{i, Length[peakGradientWidth]}]*)


(* ::Input:: *)
(*ListPlot[{peakGradientWidth,Table[{n,9/n}, {n,5,80}]},PlotStyle->{Red, Blue} ]*)


(* ::Input:: *)
(*subPeakGradientWidth = ParallelTable[{n,NSolve[phiPrime[n,x]== n/12&&x>0,x]}, {n,5,80}];*)


(* ::Input:: *)
(*subPeakGradientWidth = subPeakGradientWidth[[2;;]];*)


(* ::Input:: *)
(*subPeakGradientWidth[[All, 2]]= x/. subPeakGradientWidth[[All, 2]];*)


(* ::Input:: *)
(*Do[subPeakGradientWidth[[i, 2]]= subPeakGradientWidth[[i, 2]][[2]]- subPeakGradientWidth[[i, 2]][[1]],{i, Length[subPeakGradientWidth]}];*)


(* ::Input:: *)
(*subPeakGradientWidth*)


(* ::Input:: *)
(*ListPlot[{subPeakGradientWidth,Table[{n,9/n^(1/2)}, {n,5,80}]},PlotStyle->{Red, Blue} ]*)


(* ::Input:: *)
(*Table[NIntegrate[phiPrime[n,x]^{1/3},{x,0,Exp[3]}],{n,5,20} ]*)


(* ::Input:: *)
(*(*I want to mess around and see if taking the partition to be proportional to \[Sqrt]1/f'(x) works well*)*)


(* ::Input:: *)
(*Plot[{Derivative[0,1][\[Phi]][10,x], Derivative[0,2][\[Phi]][10,x], Derivative[0,3][\[Phi]][10,x], Derivative[0,4][\[Phi]][10,x], Derivative[0,5][\[Phi]][10,x], Derivative[0,6][\[Phi]][10,x] },{x,0,6},PlotLegends->{"1","2","3","4", "5","6"}]*)


(* ::Input:: *)
(*Plot[Derivative[0,6][\[Phi]][10,x], {x,0,6}]*)


(* ::Input:: *)
(*Needs["NumericalCalculus`"]*)


(* ::Input:: *)
(*Plot[ND[\[Phi][10,x],{x,3},x0], {x0,0,6}, PlotRange->All]*)


(* ::Input:: *)
(*\[Psi][n_, x_, \[Beta]_,\[Delta]_]:= \[Phi][n, Exp[-\[Beta]*Log[1/\[Delta]]*x]];*)


(* ::Input:: *)
(*Integrate[\[Psi][n, x, \[Beta], \[Delta]],{x,-1,1}, Assumptions->\[Delta] > 0 && \[Delta]<1 && \[Beta]>0&&n>0]*)


(* ::Input:: *)
(*%//FullSimplify*)


(* ::Input:: *)
(*% /. \[Beta]->1*)


(* ::Input:: *)
(*Integrate[\[Psi][n, x, 1],{x,0,c}, Assumptions->c>0]*)


(* ::Input:: *)
(*Plot[\[Psi][10,x,1, Exp[-3]], {x,-1,1}]*)


(* ::Input:: *)
(*n=30;*)


(* ::Input:: *)
(*Plot[{\[Phi][n,x],3/4*(n-1),1/4*(n-1)}, {x,0,6}]*)


(* ::Input:: *)
(*Limit[(\[Phi][n,1+h]-(n-1)+\[Phi][n,1-h])/h^2,h->0]*)


(* ::Input:: *)
(*phiPrimePrime[5,0.99]*)


(* ::Input:: *)
(*phiPrime[n_,x_]:= Derivative[0,1][\[Phi]][n,x];*)


(* ::Input:: *)
(*phiPrimePrime[n_,x_] := Derivative[0, 2][\[Phi]][n,x]*)


(* ::Input:: *)
(*phiPrimePrimeMax = ParallelTable[FindMaximum[Abs[phiPrimePrime[n,x]],{x,0,1}],{n,10,30}]*)


(* ::Input:: *)
(*ListPlot[phiPrimePrimeMax[[All, 1]]]*)


(* ::Input:: *)
(*phiPrimePrimeMax[[1;3]][[1]]*)


(* ::Input:: *)
(*Plot[phiPrime[10,x],{x,0,3}]*)


(* ::Input:: *)
(*phiApprox[n_,x_]:=- ((n-1)(1+x)^n -n (1+x)^(n-1)+1)/(x(1-x)(1-(1+x)^n));*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*phiApproxLimit[n_,x_]:=-((n-1)Exp[n*x]-n*Exp[n*x]+1)/(x(1-x)(1-Exp[n*x]));*)


(* ::Input:: *)
(*Plot[{phiApprox[20,x], phiApproxLimit[20,x]+1/2},{x,-0.5,0.5}]*)


(* ::Input:: *)
(*Limit[phiApproxLimit[n,x],x->0]*)


(* ::Input:: *)
(*Limit[phiApprox[n,x],x->0]*)


(* ::Input:: *)
(*Apart[f[c, n,-1]]*)


(* ::Input:: *)
(*Apart[(E^c-n (E^c)^n+(n-1) (E^c)^(n+1))/((1-E^c) (1-(E^c)^n))]//FullSimplify*)


(* ::Input:: *)
(*Apart[(E^c-n (E^c)^n+(n-1) (E^c)^(n+1))/((1-E^c) (1-(E^c)^n))]*)


(* ::Input:: *)
(*f[c,n,x]*)


(* ::Input:: *)
(*f[c,n,0]*)
