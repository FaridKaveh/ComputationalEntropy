(* ::Package:: *)

(* ::Input:: *)
(*ratioRecursion[n_]:= ratioRecursion[n]= If[n>0, ratioRecursion[0]-1/2*Sum[ratioRecursion[m]^2,{m,0,n-1}],z]//Expand; *)


(* ::Input:: *)
(*ratioRecursion[1]/. z-> 2*)


(* ::Input:: *)
(*ratioRecursion[3]*)


(* ::Input:: *)
(*z-(3 z^2)/2+(3 z^3)/2-(9 z^4)/8+(5 z^5)/8-z^6/4+z^7/(1r6)-z^8/128*)


(* ::Input:: *)
(*coeff3List = Table[Coefficient[ratioRecursion[n], z, 3],{n,2,10}]*)


(* ::Input:: *)
(*coeff3DiffList = coeff3List[[2;;]]- coeff3List[[;;-2]]*)


(* ::Input:: *)
(*coeff4List = Table[Coefficient[ratioRecursion[n], z, 4],{n,2,10}]*)


(* ::Input:: *)
(*coeff4DiffList = coeff4List[[2;;]]- coeff4List[[;;-2]]*)


(* ::Input:: *)
(*coeff3DiffDiffList = coeff3DiffList[[2;;]]-coeff3DiffList[[;;-2]]*)


(* ::Input:: *)
(*coeff4DiffDiffList = coeff4DiffList[[2;;]]-coeff4DiffList[[;;-2]]*)


(* ::Input:: *)
(*coeff4DiffDiffDiffList=coeff4DiffDiffList[[2;;]]-coeff4DiffDiffList[[;;-2]]*)


(* ::Input:: *)
(*ratioRecursion[3]/. z->1*)


(* ::Text:: *)
(*It  look like the coefficient of z^2 is growing linearly, the coefficient of z^3 is growing quadratically, and in general the coefficient of z^d is growing as n^(d-1). *)
