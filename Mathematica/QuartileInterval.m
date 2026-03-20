(* ::Package:: *)

(* ::Input:: *)
(*phiApprox[n_,r_]:=-Exp[-r]+n^2(1-r)/r^2 ;*)


(* ::Input:: *)
(*s=Solve[(1-x)/x^2-a==0 && a<= 4/3,Element[x,Reals] ]*)


(* ::Input:: *)
(*xx = s[[ 2,1]]*)


(* ::Input:: *)
(*N[xx /. a -> 1/10]*)


(* ::Input:: *)
(*P*)


(* ::Input:: *)
(*approxUpperSolutions= Table[NSolve[phiApprox[n,r]-3*n/4==0, Element[r, Reals]],{n,5,300}];*)


(* ::Input:: *)
(*approxAsymptoticUpperSolutions = Table[N[xx /. a -> 3/(4*n)],{n,5,300}];*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*approxUpperSolutions = approxUpperSolutions[[All ,2]];*)


(* ::Input:: *)
(*approxAsymptoticUpperSolutions - approxUpperSolutions*)


(* ::Input:: *)
(*f [z_]:= ReplaceAll[r, z];*)


(* ::Input:: *)
(*approxUpperSolutionsEval = Map[f, approxUpperSolutions];*)


(* ::Input:: *)
(*x /. approxAsymptoticUpperSolutions*)


(* ::Input:: *)
(*approxAsymptoticUpperSolutionsEval = Map[ReplaceAll[x, #]&, approxAsymptoticUpperSolutions]*)


(* ::Input:: *)
(*Export["Documents/NonGitCode/ComputationalEntropy/UpperApproxSols.csv", approxUpperSolutionsEval];*)


(* ::Input:: *)
(*Export["Documents/NonGitCode/ComputationalEntropy/UpperApproxAsymptoticSols.csv", approxAsymptoticUpperSolutionsEval];*)


(* ::Input:: *)
(*Import["Documents/NonGitCode/ComputationalEntropy/UpperApproxAsymptoticSols.csv"]*)


(* ::Input:: *)
(*ResourceFunction["KullbackLeiblerDivergence"][p,q]*)


(* ::Input:: *)
(*p =ProbabilityDistribution[{0.7,0.2,0.1},{x,1,3}]*)


(* ::Input:: *)
(*q =ProbabilityDistribution[{0.1,0.2,0.7},{x,1,3}]*)
