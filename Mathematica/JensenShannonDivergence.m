(* ::Package:: *)

(* ::Input:: *)
(*(*copy pasted from Mathematica stackexchange. TermErsetzung uses user defined variables to simplify expression/eliminate variables from an expression.*)*)


(* ::Input:: *)
(*\[CapitalLambda][n] =\[CapitalLambda][n_]:= DiagonalMatrix[Join[{-r1},ConstantArray[-(r1+r2),n-2],{-r2}]]+DiagonalMatrix[ConstantArray[r2,n-1],1]+DiagonalMatrix[ConstantArray[r1,n-1],-1];*)


(* ::Input:: *)
(*\[CapitalLambda][3]//MatrixForm*)


(* ::Input:: *)
(*assum= r1>r2 && r2 > 0; *)


(* ::Input:: *)
(*sortWithAssumptions[Eigenvalues[\[CapitalLambda][3]],*)
(*assum]*)


(* ::Input:: *)
(*sortWithAssumptions[Eigenvalues[\[CapitalLambda][4]],assum]*)


(* ::Input:: *)
(*sortWithAssumptions[Eigenvalues[\[CapitalLambda][5]],assum]*)


(* ::Input:: *)
(*sortWithAssumptions[Eigenvalues[\[CapitalLambda][10]], assum]*)


(* ::Input:: *)
(*Cos[Pi/10]*)


(* ::Input:: *)
(*Sqrt[6+Sqrt[5]]*)


(* ::Input:: *)
(*N[sortWithAssumptions[Eigenvalues[\[CapitalLambda][10]],assum]]/. {r1->2, r2->1}*)


(* ::Input:: *)
(*Table[N[-1-2-2*Sqrt[2]Cos[k*Pi/10]],{k,1,10}]*)


(* ::Input:: *)
(*N[Eigenvectors[\[CapitalLambda][6]]] /. {r1->2, r2->1}*)


(* ::Input:: *)
(*candidateVecs[r1_,r2_,N_,m_]:= Table[Sqrt[(r1/r2)^(i-1)]*Sin[Pi*i*m/N],{i,1,N}]; *)


(* ::Input:: *)
(*N[candidateVecs[2,1,6,3]]*)


(* ::Input:: *)
(*Table[N[-1-2-2*Sqrt[2]Cos[k*Pi/13]],{k,1,13}]*)


(* ::Input:: *)
(*N[sortWithAssumptions[Eigenvalues[\[CapitalLambda][13]],assum]]/. {r1->2, r2->1}*)


(* ::Input:: *)
(*\[CapitalLambda][6]//MatrixForm*)


(* ::Input:: *)
(*CharacteristicPolynomial[\[CapitalLambda][6],x]*)


(* ::Input:: *)
(*toeplitzLambda[n_] := DiagonalMatrix[ConstantArray[-r1-r2,n]]+ DiagonalMatrix[ConstantArray[r2,n-1],1]+ DiagonalMatrix[ConstantArray[r1,n-1],-1]*)


(* ::Input:: *)
(*p[x]= CharacteristicPolynomial[toeplitzLambda[6],x]*)


(* ::Input:: *)
(*q[x]=CharacteristicPolynomial[\[CapitalLambda][7],x]*)


(* ::Input:: *)
(*PolynomialRemainder[q[x],p[x],x]*)


(* ::Input:: *)
(*toeplitzLambda[5]//MatrixForm*)


(* ::Input:: *)
(*totalEnt[M_]:=Module[{F =1/M}, F/2*Sum[Exp[-k/2*F]/Sinh[k/2*F],{k,1,M}] ];*)


(* ::Input:: *)
(*approximatingIntegral[M_]:=1/2* NIntegrate[Exp[-x/2]/Sinh[x/2],{x,1/M,1}];*)


(* ::Input:: *)
(*ListPlot[{Table[totalEnt[M,Exp[-1]],{M,200,500}],Table[approximatingIntegral[M],{M,200,500}], Table[Log[(1-Exp[-1])/(1-Exp[-1/M])],{M,200,500}]},PlotRange->{Automatic,{0,8}}]*)


(* ::Input:: *)
(*totalEnt[10,0.1]*)


(* ::Input:: *)
(*totalEnt[12,0.1]*)


(* ::Input:: *)
(*Plot[(Exp[3/2*x]-1/2*Exp[x/2])/Sinh[x/2],{x,1,10}]*)


(* ::Input:: *)
(*Sum[j*x^j, {j,0,N-1}]//FullSimplify*)


(* ::Input:: *)
(*N[Exp[7]]*)


(* ::Text:: *)
(*Below  I'm doing some analysis to observe the scaling with M and N, setting \[Delta] = 1/e^3 ~ 0.05 for simplicity. I use n in place of N because Mathematica has a built in function called N. *)


(* ::Input:: *)
(*(*piN is the probability mass in the n-th state after k steps*)*)


(* ::Input:: *)
(*rateRatio[M_,c_,k_]:= Exp[-c*k/M];*)


(* ::Input:: *)
(*adjacentDistsKLD[n_,M_,c_,k_]:=If[k !=0,c/M*(rateRatio[M,c,k]-n*rateRatio[M,c,k]^n+(n-1)*rateRatio[M,c,k]^(n+1))/((1-rateRatio[M,c,k])(1-rateRatio[M,c,k]^n)),c*(n-1)/(2*M)];*)


(* ::Input:: *)
(*totalEntProd[n_,M_,c_]:=-(n-1)*c+Sum[adjacentDistsKLD[n,M,c,k],{k,-M,M}];*)


(* ::Input:: *)
(*N[totalEntProd[10,22,3]]*)


(* ::Input:: *)
(*cfTotalEntProd[10,22,3]*)


(* ::Input:: *)
(*p1=ListPlot[Table[N[totalEntProd[10,m]],{m,5,200}]];*)


(* ::Input:: *)
(*p2= Plot[0.12, {x,0,200},PlotStyle->Red];*)


(* ::Input:: *)
(*Show[p1,p2]*)


(* ::Output:: *)
(*Graphics[{{{}, Annotation[{{Annotation[{Directive[PointSize[0.009166666666666668], RGBColor[0.368417, 0.506779, 0.709798], AbsoluteThickness[2]], Point[CompressedData["*)
(*1:eJw11A1UjPkeB/D/2Cybe2lTaSVNK6HkJYRo+6VSeau8jUhGealWqWXRjfpn*)
(*rc0tG8pde4lZu3vvWadDaSTEPIoibyWlKy+Tl7YcEastOXR/e3xnzpkz5zPf*)
(*+c73Oc8z8zhGrp27socQ4gI//3r98GjzFtrYFENMT8IblLAg7/MJdSq4N42x*)
(*jvti1u733h9sQbL7+E/xZ7tgK9IeM9t6oKwDtiWLOwcNYZHt8CBSvm4t6F77*)
(*B6wm8WRoj2tVL+HPSbv/642ZiW2wExlV6xv+vuM57Ezqdqfc8NRn8HCiHiWf*)
(*vix6CrsQffPDJ35OLfBIon27dBHnfodHEXU++NItpQkeQ9obIem9Ip7AY0nb*)
(*fmzKorDHsDsZA08N0655BI8jnU1w48c5D+HxpFZtGFJ8rRGeQFS3d2nQAJM9*)
(*SL3sQviTeCM8kURGeHvnrw/gSSS3j1iesO0+PJnIZ0vSww33YE+ivOC04OS7*)
(*8BSizTVX3mQ1wFNJydRHLym8A3uRMs6zwP7x/+AvSJT6zLN0NNmbpP7ITreY*)
(*epiIkisj087c/mBJJBI1eyYPgIUPiT6feOxLrkPOnlP06NXvtcinkfIs2yt/*)
(*CSynkehVds+/7hZyX5LOHTs9NLD0JUVz45zF/RrkfqQ4GMbHxcLSj49v7MPW*)
(*tzeR+5N8adY8dQ8s/YmO/1rUx82UTyd6YD7T8mo18ukkL2d/03ctLAJIBibu*)
(*KLM25QEkcitmvjFUIQ8kZa6z+eY4WLKnBT+zG2zKg0gOcp4Z9vMN5GyzbD9z*)
(*C1jMIJnlt/l92nXk7LS1Zi86ryGfSeJgc82P62HJjmtfcv71VeSzSDiUDB+Z*)
(*BEu2ZmDGLypTPpvzmhmdO68gZ//HWdtpD4s5JL3M9JsKKpHPIRGvbgoOhEUw*)
(*yYBgW83Dy8iDSZTvPReTCosQkqs3rFvpAFMInx/zqhGll/B5zm3SA/athhX2*)
(*0oaeOf1gEUpyYJ9q1ekK9ENJ7HZorVgFS86/Cu1x3RpW2FuDer4rL0d/Lsk1*)
(*5Oj9D5jY3Td/Th0NS/blqKdHmi6iz9Y3hRw9BIt5JCw7HDcthmkeyXS79A4b*)
(*WHLeZS8H1V5An3Nf7dXbObCYTyLPtmXgQpjYryNV9bawnE/yuNUT1b0y9Nmz*)
(*/bszDsNiAQmf5NmxMTAtIFmUqNk9Fpbs1Nhhf3aVos+fv63y/f4iLBaSqEj6*)
(*JXg3TOyE9foxEbBcSLLYym/4SFOf834p37m9PY++hqR9nsWkKzBpSLgfqPQ+*)
(*AEt2VunrqfGwwv6sfPBwH1N/Ecn/bnHqsjL12aEuLnktCvqL+H71dN9EA6yw*)
(*h0fa/WsvLMJI3M/+9/k1MLGrmz31fqY+2yEqLNre1GdveflpQasB/cUkWoap*)
(*u3+Cif0+7mq+BpbsuLSokr6wwnbWZdhWnEN/CYnoHVQiYWIb9TcOToEle+zZ*)
(*Wyc7zqLPfvFmQrceFuEkbk13jFsHE3tJe+8ud1iyHz/RHfyjBH12WnnDvBOw*)
(*WMrHv77ZchNM7Etpo2unwJLtWhOSI0x99ukVjjPKz6AfwddnyG9tmTCxMx+r*)
(*t86HJTthXVvnIFhhbzyVF9x0Gv1lJKy7rNPyYWJXOtmkJ8OSXeZpWBYAK+xZ*)
(*FUEfWZn6WhLPY/rHN576YDW7LDF3/zGY2LPSM75LgbXsui8Pu82BJbt3cfmO*)
(*wbCObVfy9ocXxdhju0ZEzj8PG9nJ5pPOZMNiOYlHR2svrYLV7EblaJInTOwf*)
(*54RU9oW1bPmZ9uSjk9hnPz293+sUrGOnV98Oy4IV9qqJ3b1XwUZ2DlkGesEi*)
(*ksQQlbOVNaxmq/ZHxbYWYZ9dtqdXYDmsZYe4Lj9yCJZs80vV3yfBur++b8HV*)
(*V/Nghd1w4lbNKNjI1kxKHW0Oiyg+f/0SPmo6gX12/fXFs0thYle/UvU5BGvZ*)
(*z6M8PDfDkn2t5+36MFjHjg+oejwRVtjuxXbhNrCR3agzTG3XY38F/59117fd*)
(*gtXsdzNWu+thYsdUFfrmwFp2pq6laD0s2Xdtgv65ANaxvxpmX+IBK+xR/c7M*)
(*sIWN7LaPt47vKsT+ShJmb+5svAur2XLypP4GmNijfKx7Hoa1bG3snzO/hSU7*)
(*Nz+6KRrWsTsSVTWzYIX9zj3CYixsZHuucMq1Nu2v4uvtotrUdRz77Lahvx16*)
(*ABN7xLR6y4uwlp2VElp1BJZsX8P9ul2wjm2XGzJ0I6ywYyamnF4KG9nhvfz3*)
(*+sFiNf++9Ol6V9M+2+aZ+4D+pn22mce4kq4C7LPtqlIOP4Ql++Z2i8uVsI6d*)
(*sqt5VCGssGtj/lazHzayxxdu12+DRTTfL/uuvhkHq9m1otRVAxO76Xq+gUz7*)
(*7GWRoTtdTPtstUt5tlWB9/8B5BxwXw==*)
(*"]]}, "Charting`Private`Tag#1"]}}, <|"HighlightElements" -> <|"Label" -> {"XYLabel"}, "Ball" -> {"IndicatedBall"}|>, "LayoutOptions" -> <|"PanelPlotLayout" -> <||>, "PlotRange" -> {{0., 196.}, {0, 0.7351240719203194}}, "Frame" -> {{False, False}, {False, False}}, "AxesOrigin" -> {0., 0}, "ImageSize" -> {360, 360/GoldenRatio}, "Axes" -> {True, True}, "LabelStyle" -> {}, "AspectRatio" -> GoldenRatio^(-1), "DefaultStyle" -> {Directive[PointSize[0.009166666666666668], RGBColor[0.368417, 0.506779, 0.709798], AbsoluteThickness[2]]}, "HighlightLabelingFunctions" -> <|"CoordinatesToolOptions" -> ({Identity[Part[#, 1]], Identity[Part[#, 2]]}& ), "ScalingFunctions" -> {{Identity, Identity}, {Identity, Identity}}|>, "Primitives" -> {}, "GCFlag" -> False|>, "Meta" -> <|"DefaultHighlight" -> {"Dynamic", None}, "Index" -> {}, "Function" -> ListPlot, "GroupHighlight" -> False|>|>, "DynamicHighlight"], {{}, {}}}, Annotation[{{{{}, {}, Annotation[{Directive[Opacity[1.], AbsoluteThickness[2], RGBColor[1, 0, 0]], Line[CompressedData["*)
(*1:eJxTTMoPSmViYGAwAWIQrdT/d/E8uYt2O+RaXwfu2Gd/auLtwhfp/+1hfK+9*)
(*7H7P0vkdYPyzvGacLLEKcL5Tv+uB5f4acH6q/i9eQ14DON9XM/WjmLsJnL/p*)
(*Sm3pSQsLON9aSGs9S70NnJ/+e9LcpREOcH7+sefG632d4PyuKDbVvzkucH7y*)
(*8eo0www3OP8gu2RgdqQHnG8o2DDtZYkXnJ/w2VbHL8cHzl8476jM914/OH9z*)
(*n9XtS0EBcH7JLtuAuT6BcP7+U0s/dUYHwfmZ7pZ7MyOC4fw5Kwy3ZmeFwPkT*)
(*P+9tLCgPhfOfrSotyygKg/OPuE2a0dQUDucz+t961N8QAeczOG5jXFAZCed3*)
(*iH/3vdQeBecXRCUf+t4cDec/bDRJsZ8aA+eLTJ55q3NhLJy/TECr8vjsOER4*)
(*Fcm7qq+Oh/PnKSyQsQ1JgPP31vxiyLiA4Ct6s/9RDk+E87ec1+y+eQXB7zn2*)
(*z0AhNgnOn1z8MivhDoJfIyrHrxSZDOev1GQ9VfIAwWf7wih5MC4Fzl9usLFu*)
(*3nMEXzNpld/f3FQ4/7bnzk2hrxH8S4urdO2L0+D8H5sDbZQ+Ifj/dxRtbctL*)
(*h/O9Ddxca74i+Mdj9TOzizPgfCv2gA1bdyL46zYUfP//H8EHAMCBl/4=*)
(*"]]}, "Charting`Private`Tag#1"]}}, {}}, <|"HighlightElements" -> <|"Label" -> {"XYLabel"}, "Ball" -> {"InterpolatedBall"}|>, "LayoutOptions" -> <|"PanelPlotLayout" -> <||>, "PlotRange" -> {{0, 200}, {0., 0.24}}, "Frame" -> {{False, False}, {False, False}}, "AxesOrigin" -> {0, 0}, "ImageSize" -> {360, 360/GoldenRatio}, "Axes" -> {True, True}, "LabelStyle" -> {}, "AspectRatio" -> GoldenRatio^(-1), "DefaultStyle" -> {Directive[Opacity[1.], AbsoluteThickness[2], RGBColor[1, 0, 0]]}, "HighlightLabelingFunctions" -> <|"CoordinatesToolOptions" -> ({Identity[Part[#, 1]], Identity[Part[#, 2]]}& ), "ScalingFunctions" -> {{Identity, Identity}, {Identity, Identity}}|>, "Primitives" -> {}, "GCFlag" -> False|>, "Meta" -> <|"DefaultHighlight" -> {"Dynamic", None}, "Index" -> {}, "Function" -> Plot, "GroupHighlight" -> False|>|>, "DynamicHighlight"]}, AspectRatio -> GoldenRatio^(-1), Axes -> {True, True}, AxesLabel -> {None, None}, AxesOrigin -> {0., 0}, DisplayFunction -> Identity, Frame -> {{False, False}, {False, False}}, FrameLabel -> {{None, None}, {None, None}}, FrameTicks -> {{Automatic, Automatic}, {Automatic, Automatic}}, GridLines -> {None, None}, GridLinesStyle -> Directive[GrayLevel[0.5, 0.4]], Method -> {"AxisPadding" -> Scaled[0.02], "DefaultBoundaryStyle" -> Automatic, "DefaultGraphicsInteraction" -> {"Version" -> 1.2, "TrackMousePosition" -> {True, False}, "Effects" -> {"Highlight" -> {"ratio" -> 2}, "HighlightPoint" -> {"ratio" -> 2}, "Droplines" -> {"freeformCursorMode" -> True, "placement" -> {"x" -> "All", "y" -> "None"}}}}, "DefaultMeshStyle" -> AbsolutePointSize[6], "DefaultPlotStyle" -> {Directive[RGBColor[0.368417, 0.506779, 0.709798], AbsoluteThickness[2]], Directive[RGBColor[0.880722, 0.611041, 0.142051], AbsoluteThickness[2]], Directive[RGBColor[0.560181, 0.691569, 0.194885], AbsoluteThickness[2]], Directive[RGBColor[0.922526, 0.385626, 0.209179], AbsoluteThickness[2]], Directive[RGBColor[0.528488, 0.470624, 0.701351], AbsoluteThickness[2]], Directive[RGBColor[0.772079, 0.431554, 0.102387], AbsoluteThickness[2]], Directive[RGBColor[0.363898, 0.618501, 0.782349], AbsoluteThickness[2]], Directive[RGBColor[1, 0.75, 0], AbsoluteThickness[2]], Directive[RGBColor[0.647624, 0.37816, 0.614037], AbsoluteThickness[2]], Directive[RGBColor[0.571589, 0.586483, 0.], AbsoluteThickness[2]], Directive[RGBColor[0.915, 0.3325, 0.2125], AbsoluteThickness[2]], Directive[RGBColor[0.40082222609352647`, 0.5220066643438841, 0.85], AbsoluteThickness[2]], Directive[RGBColor[0.9728288904374106, 0.621644452187053, 0.07336199581899142], AbsoluteThickness[2]], Directive[RGBColor[0.736782672705901, 0.358, 0.5030266573755369], AbsoluteThickness[2]], Directive[RGBColor[0.28026441037696703`, 0.715, 0.4292089322474965], AbsoluteThickness[2]]}, "DomainPadding" -> Scaled[0.02], "PointSizeFunction" -> "SmallPointSize", "RangePadding" -> Scaled[0.05], "OptimizePlotMarkers" -> True, "IncludeHighlighting" -> "CurrentPoint", "HighlightStyle" -> Automatic, "OptimizePlotMarkers" -> True, "CoordinatesToolOptions" -> {"DisplayFunction" -> ({Identity[Part[#, 1]], Identity[Part[#, 2]]}& ), "CopiedValueFunction" -> ({Identity[Part[#, 1]], Identity[Part[#, 2]]}& )}}, PlotRange -> {{0., 196.}, {0, 0.7351240719203194}}, PlotRangeClipping -> True, PlotRangePadding -> {{Scaled[0.02], Scaled[0.02]}, {Scaled[0.02], Scaled[0.05]}}, Ticks -> {Automatic, Automatic}]*)


(* ::Text:: *)
(*How  does  the  entropy  production  scale  with  M  for  N = 2? *)


(* ::Input:: *)
(*ListPlot[{Table[totalEntProd[2, m],{m,2,100, 5}], Table[2/m,{m,2,100,5}] }]*)


(* ::Text:: *)
(*How  does  EP  scale  with  N  if  we  allow  M = 10  buffer  states  per  computational  state?*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*ListPlot[Table[cTotalEntProd[n, (n-1)],{n,2,200, 5}]]*)


(* ::Text:: *)
(*This  looks logorithmic or bounded...*)
(**)


(* ::Input:: *)
(*linearBufferScaling1 = Table[{n,cTotalEntProd[n, (n-1)] }, {n,2,200,5}];*)


(* ::Input:: *)
(*linearBufferScaling10 = Table[{n,cTotalEntProd[n, 10*(n-1)] }, {n,2,200,5}];*)


(* ::Input:: *)
(*linearBufferScaling20 =  Table[{n,cTotalEntProd[n, 20*(n-1)] }, {n,2,200,5}];*)


(* ::Input:: *)
(*linearBufferScaling30 =  Table[{n,cTotalEntProd[n, 30*(n-1)] }, {n,2,200,5}];*)


(* ::Input:: *)
(*ListLogPlot[{linearBufferScaling1, linearBufferScaling10, linearBufferScaling20}]*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*Log[1.2]/0.148*)


(* ::Input:: *)
(*Plot[Log[10*x]/23,{x,2,100}, PlotRange->Automatic]*)


(* ::Input:: *)
(*linearBufferScaling*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*0.149257-0.149806*)
(**)


(* ::Input:: *)
(*-0.000549/Log[22/82]*)


(* ::Input:: *)
(*Integrate[(Exp[-c*x]+(n/5-1)*Exp[-(n+1)*c*x]-n/5*Exp[-n*c*x])/((1-Exp[-c*x])*(1-Exp[-n*c*x])),{x,-1,1},Assumptions->n>0&& c>0]*)


(* ::Input:: *)
(*Series[(Exp[-c*x]+(n-1)*Exp[-(n+1)*c*x]-n*Exp[-n*c*x])/((1-Exp[-c*x])*(1-Exp[-n*c*x]))-1/2(n-1),{x,0,5}]*)


(* ::Input:: *)
(*NSolve[1-Exp[-3]==(1-x)/(1-x^12)]*)


(* ::Input:: *)
(*Log[0.04978]*)


(* ::Input:: *)
(*Plot[(Exp[-c*x]+(n-1)*Exp[-(n+1)*c*x]-n*Exp[-n*c*x])/((1-Exp[-c*x])*(1-Exp[-n*c*x]))/. n->10 /. c->0.05,{x,-1,1}]*)


(* ::Input:: *)
(*linearBufferScaling10*)


(* ::Input:: *)
(*(*another version of EP functions for numerical evaluation*)*)


(* ::Input:: *)
(*NrateRatio[M_,k_]:= N[Exp[-3*k/M]];*)


(* ::Input:: *)
(*NpiN[n_,M_,k_] := If[k!=0, (1-NrateRatio[M,k])/(1-NrateRatio[M,k]^n), 1/n];*)


(* ::Input:: *)
(*NadjacentDistsKLD[n_,M_,k_]:=-Log[NpiN[n,M,k+1]/NpiN[n,M,k]]+If[k !=0,3/M*(NrateRatio[M,k]-n*NrateRatio[M,k]^n+(n-1)*NrateRatio[M,k]^(n+1))/((1-NrateRatio[M,k])(1-NrateRatio[M,k]^n)),3*(n-1)/(2*M)];*)


(* ::Input:: *)
(*NtotalEntProd[n_,M_]:=Sum[NadjacentDistsKLD[n,M,k],{k,-M,M}];*)


(* ::Input:: *)
(*EntropySum[n_,M_] := NSum[If[k !=0,3/M*(NrateRatio[M,k]-n*NrateRatio[M,k]^n+(n-1)*NrateRatio[M,k]^(n+1))/((1-NrateRatio[M,k])(1-NrateRatio[M,k]^n)),3*(n-1)/(2*M)], {k,-M,M}]*)


(* ::Input:: *)
(*EntropySum[10,20]*)


(* ::Input:: *)
(*ListPlot[Table[NtotalEntProd[10,M],{M,10,50,5}]]*)


(* ::Input:: *)
(*EntropySum[10,50]*)


(* ::Input:: *)
(*NtotalEntProd[5,40]*)


(* ::Input:: *)
(*logSum [n_,M_]:= NSum[-Log[NpiN[n,M,k+1]/NpiN[n,M,k]],{k,-M,M}];*)


(* ::Input:: *)
(*ListPlot[Table[logSum[n,10*n],{n,5,20}]]*)


(* ::Input:: *)
(*phi[n_,c_,x_]:= If[x!=0,(Exp[-c*x]-n*Exp[-n*c*x]+(n-1)*Exp[-(n+1)*c*x])/((1-Exp[-c*x])*(1-Exp[-n*c*x])), 1/2*(n-1)];*)


(* ::Input:: *)
(*Plot[{phi[5,3,x],phi[10,3,x]},{x,-1,1}]*)


(* ::Input:: *)
(*exp[n_,c_,x_]:= Exp[-c*x];*)


(* ::Input:: *)
(*Composition[ phi,exp][5,3,1/2]*)


(* ::Input:: *)
(*phiPrime[n_,c_,x_] = Derivative[0,0,1][phi][n,c,x]*)


(* ::Input:: *)
(*FindMaximum[phiPrime[n,c,x],x]*)


(* ::Input:: *)
(*Limit[phiPrime[n,c,x],x->0]*)


(* ::Input:: *)
(*Plot[{phiPrime[5,3,x],phiPrime[3,3,x],phiPrime[15,3,x]},{x,-1,1}, PlotRange->{Automatic,{0,-20}}]*)


(* ::Input:: *)
(*phiPrimePrime[n_,c_,x_] = Derivative[0,0,2][phi][n,c,x];*)


(* ::Input:: *)
(*Limit[phiPrimePrime[n,c,x],x->0]*)


(* ::Input:: *)
(*ListPlot[Table[phi[n,3,-1],{n,5,20,2}]]*)


(* ::Input:: *)
(*phi[n,c,-1]*)


(* ::Input:: *)
(*ls1= Table[{n,phi[n,1,1]},{n,5,20,2}];*)


(* ::Input:: *)
(*ls2= Table[{n,Exp[-1]/(1-Exp[-1])},{n,5,20,2}];*)


(* ::Input:: *)
(*ListPlot[{ls1,ls2},PlotStyle->{Red, Green}]*)


(* ::Input:: *)
(* N[Table[{n,phi[n,1,1]-Exp[-1]/(1-Exp[-1])},{n,5,20,2}]]*)


(* ::Input:: *)
(*totalEnts = Table[{m,cfTotalEntProd[10, m,3]/3}, {m,5,20,2}]*)


(* ::Input:: *)
(*integralErrs = Table[{m, 1/m*(phi[10,3,-1]-phi[10,3,1])},{m,5,20,2}];*)


(* ::Input:: *)
(*ListPlot[{totalEnts, integralErrs}, PlotStyle->{Red, Green}]*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*Limit[phi[n,c,x],x->0]*)


(* ::Input:: *)
(*totalEntsLinScale = Table[{\[Alpha],cfTotalEntProd[10, 10*\[Alpha],3]/3}, {\[Alpha],5,20,2}];*)


(* ::Input:: *)
(*boundsLinScale = Table[{\[Alpha], 1/(\[Alpha]*10)*(phi[10,3,-1]-phi[10,3,1])},{\[Alpha],5,20,2}];*)


(* ::Input:: *)
(*approximateBoundsLinScale = Table[{\[Alpha],1/\[Alpha]-Exp[-3]/(1-Exp[-3])}, {\[Alpha],5,20,2}];*)


(* ::Input:: *)
(*ListPlot[{totalEntsLinScale, boundsLinScale, approximateBoundsLinScale},PlotStyle->{Red, Green, Blue}]*)


(* ::Input:: *)
(*totalEntLinScale= Table[{n,cfTotalEntProd[n,5n,2]/2}, {n,5,30,2}]*)


(* ::Input:: *)
(*Plot[{phi[5,3,x],phi[10,3,x], phi[20,3,x]},{x,-1.2,1.2},PlotStyle->{Red,Green,Blue}]*)


(* ::Input:: *)
(*Plot[{phi[5,3,x],phi[10,3,x],phi[20,3,x],0 (*dummy curve for legend*)},{x,-1.2,1.2},PlotStyle->{Red,Green,Blue,White},PlotLegends->Placed[LineLegend[{Style[Subscript[\[CurlyPhi],5][x],Italic],Style[Subscript[\[CurlyPhi],10][x],Italic],Style[Subscript[\[CurlyPhi],20][x],Italic],Style[Row[{Subscript["C","\[Delta]"]," = 3"}],Italic]},LegendMarkers->""],{Right,Center}], AxesLabel->Automatic, LabelStyle->Directive[Bold, Black]]*)
(**)


(* ::Input:: *)
(*bound[n_,M_,c_] = 1/M*(phi[n,c,-1]-phi[n,c,1]);*)


(* ::Input:: *)
(*bound2[n_,M_,c_]= 1/M*(phi[n,c,-1]-phi[n,c,0]);*)


(* ::Input:: *)
(*EntprodNForPlot= Table[{n,cfTotalEntProd[n,10,3]/3},{n,5,30,2}];*)


(* ::Input:: *)
(*EntprodMForPlot= Table[{m,cfTotalEntProd[10,m,3]/3},{m,5,30,2}];*)


(* ::Input:: *)
(*boundM = Table[{m,bound[10,m,3]},{m,5,30,2}];*)


(* ::Input:: *)
(*boundN = Table[{n,bound[n,10,3]},{n,5,30,2}];*)


(* ::Input:: *)
(*bound2M = Table[{m,bound2[10,m,3]},{m,5,30,2}];*)


(* ::Input:: *)
(*bound2N =Plot[bound2[n,10, 3],{n,5,30},PlotStyle->Blue];*)


(* ::Input:: *)
(*lsPlot = ListPlot[{EntprodNForPlot,boundN}, PlotStyle->{Red, Green}];*)


(* ::Input:: *)
(*Show[bound2N, lsPlot]*)


(* ::Input:: *)
(*boundN/EntprodNForPlot*)


(* ::Input:: *)
(*Plot[bound[10,n,3]/2,{n,5,30}]*)


(* ::Input:: *)
(*cfTotalEntProd[10,10,3]/3-bound[10,10,3]/2*)


(* ::Input:: *)
(*phiCentered[n_,c_,x_] := phi[n,c,x]-phi[n,c,0];*)


(* ::Input:: *)
(*phiCentered[n,c,x]+phiCentered[n,c,-x]//FullSimplify*)


(* ::Input:: *)
(*Factor[x^(n+1)-x^n-x-1]*)


(* ::Input:: *)
(*totalEntsLinScale2 = Table[{n,cfTotalEntProd[n, 2n,3]}, {n,5,30,2}];*)


(* ::Input:: *)
(*totalEntsLinScale3 = Table[{n,cfTotalEntProd[n, 3n,3]}, {n,5,30,2}];*)


(* ::Input:: *)
(*totalEntsLinScale5= Table[{n,cfTotalEntProd[n, 5*n,3]}, {n,5,30,2}];*)


(* ::Input:: *)
(*lims = Plot[{3/4,3/6,3/10},{x,5,30}, PlotStyle->{Directive[Blue,Dashed], Directive[Red, Dashed], Directive[Green, Dashed]},PlotRange->{Automatic,{0,0.8}}];*)


(* ::Input:: *)
(*ents = ListPlot[{totalEntsLinScale2, totalEntsLinScale3, totalEntsLinScale5}, PlotStyle->{Directive[Blue,Dashed], Directive[Red], Directive[Green, Dashed]}, PlotRange->{Automatic, {0,0.8}}];*)


(* ::Input:: *)
(*Show[lims, ents]*)


(* ::Input:: *)
(*lims=Plot[{3/4,3/6,3/10},{x,5,30},PlotStyle->{Directive[Blue,Dashed],Directive[Red,Dashed],Directive[Green,Dashed]},PlotRange->{Automatic,{0,0.8}},PlotLegends->None,AxesLabel->{"N",Subscript["\[CapitalSigma]","tot"]},LabelStyle->Directive[Bold, Black]];*)
(**)
(*ents=ListPlot[{totalEntsLinScale2,totalEntsLinScale3,totalEntsLinScale5, {1,1}(*dummy point*)},PlotStyle->{Directive[Blue,Dashed],Directive[Red],Directive[Green,Dashed],White (*dummy*)},PlotRange->{Automatic,{0,0.8}},PlotLegends->Placed[LineLegend[{Style[Row[{"\[Alpha] = 2"}],Italic],Style[Row[{"\[Alpha] = 3"}],Italic],Style[Row[{"\[Alpha] = 5"}],Italic],Style[Row[{Subscript["C","\[Delta]"]," = 3"}],Italic]},LegendMarkers->"---"],{1, 0.5}], AxesLabel->{"N",Subscript["\[CapitalSigma]","tot"]}, LabelStyle->Directive[Bold, Black]];*)
(**)
(*Show[lims,ents]*)
