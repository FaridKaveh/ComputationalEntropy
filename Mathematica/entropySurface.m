(* ::Package:: *)

(* ::Input:: *)
(*(*1.  rateRatio---------------------------------------------------------*)cRateRatio=Compile[{{M,_Real},{k,_Real}},Exp[-3. k/M],RuntimeOptions->"Speed",CompilationTarget->"C"          (*change to "ByteCode" if no C compiler*)];*)
(**)
(*(*2.  piN---------------------------------------------------------------*)*)
(*cPiN=Compile[{{n,_Integer},{M,_Real},{k,_Integer}},If[k!=0,With[{r=Exp[-3. k/M]},(1.-r)/(1.-r^n)],1./n],RuntimeOptions->"Speed",CompilationTarget->"C"];*)
(**)
(*(*3.  adjacentDistsKLD--------------------------------------------------*)*)
(*cAdjacentDistsKLD=Compile[{{n,_Integer},{M,_Real},{k,_Integer}},Module[{r=Exp[-3. k/M],term1,term2,rNext,piK,piK1},(*\[Pi]_n(k) and \[Pi]_n(k+1)*)piK=If[k!=0,(1.-r)/(1.-r^n),1./n];*)
(*rNext=Exp[-3. (k+1)/M];*)
(*piK1=If[k+1!=0,(1.-rNext)/(1.-rNext^n),1./n];*)
(*term1=-Log[piK1/piK];*)
(*term2=If[k!=0,3./M (r-n r^n+(n-1.) r^(n+1))/((1.-r) (1.-r^n)),3. (n-1.)/(2. M)];*)
(*term1+term2],RuntimeOptions->"Speed",CompilationTarget->"C"];*)
(**)
(*(*4.  totalEntProd------------------------------------------------------*)*)
(*cTotalEntProd=Compile[{{n,_Integer},{M,_Integer}},Module[{sum=0.,k},Do[sum+=cAdjacentDistsKLD[n,N@M,k],(*N@M promotes M to Real*){k,-M,M-1}];*)
(*sum],RuntimeOptions->"Speed",CompilationTarget->"C"];*)
(**)


(* ::Input:: *)
(*cTotalEntProd[10, 60]*)


(* ::Input:: *)
(*entropySurface= Flatten[Table[{n,m,cTotalEntProd[n,m]},{n,10,100},{m,10,200}],1];*)


(* ::Input:: *)
(*ListPlot3D[entropySurface,AxesLabel->{n,m,"entropy"},PlotRange->Automatic]*)


(* ::Input:: *)
(*(*Ensure C compilation is available*)Needs["CCompilerDriver`"];*)
(**)
(*cfRateRatio=Compile[{{M,_Real},{c,_Real},{k,_Real}},Exp[-c*k/M],CompilationTarget->"C",RuntimeAttributes->{Listable},Parallelization->True,CompilationOptions->{"ExpressionOptimization"->True}];*)
(**)
(*cfAdjacentDistsKLD=Compile[{{n,_Real},{M,_Real},{c,_Real},{k,_Real}},Module[{r=cfRateRatio[M,c,k],numerator,denom1,denom2},If[k!=0.,(numerator=r-n*r^n+(n-1)*r^(n+1);*)
(*denom1=1.-r;*)
(*denom2=1.-r^n;*)
(*(c/M)*(numerator/(denom1*denom2))),c*(n-1)/(2.*M)]],CompilationTarget->"C",RuntimeAttributes->{Listable},Parallelization->True,CompilationOptions->{"ExpressionOptimization"->True}];*)
(**)
(*cfTotalEntProd=Compile[{{n,_Real},{M,_Real},{c,_Real}},Module[{sum=0.},Do[sum+=cfAdjacentDistsKLD[n,M,c,k],{k,-M,M}];*)
(*-(n-1)*c+sum],CompilationTarget->"C",RuntimeAttributes->{},Parallelization->False,CompilationOptions->{"ExpressionOptimization"->True}];*)
(**)
