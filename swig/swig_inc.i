// Keep it here
%nodefaultctor IClonable;

%{
#define SWIG_FILE_WITH_INIT

// TODO: find a way to maintain only one headers list (with swig_exp.i)
#include "gstlearn_export.hpp"
#include "geoslib_define.h"
#include "geoslib_enum.h"
#include "geoslib_d.h"
#include "geoslib_f.h"
#include "geoslib_old_f.h"

#include "csparse_d.h"
#include "csparse_f.h"

#include "Basic/Vector.hpp"
#include "Basic/ArgumentTest.hpp"
#include "Basic/AStringable.hpp"
#include "Basic/AStringFormat.hpp"
#include "Basic/ASerializable.hpp"
#include "Basic/Rotation.hpp"
#include "Basic/Tensor.hpp"
#include "Basic/Grid.hpp"
#include "Basic/String.hpp"
#include "Basic/Interval.hpp"
#include "Basic/Limits.hpp"
#include "Basic/Utilities.hpp"
#include "Basic/CSVformat.hpp"
#include "Basic/AFunctional.hpp"
#include "Basic/FunctionalSpirale.hpp"
#include "Basic/Table.hpp"
#include "Basic/Utilities.hpp"
#include "Basic/NamingConvention.hpp"
#include "Basic/OptDbg.hpp"
#include "Basic/OptCst.hpp"
#include "Basic/OptCustom.hpp"
#include "Basic/EDbg.hpp"
#include "Basic/ECst.hpp"
#include "Basic/File.hpp"

#include "Enum/EKrigOpt.hpp"

#include "Space/Space.hpp"
#include "Space/ASpace.hpp"
#include "Space/ASpaceObject.hpp"
#include "Space/SpacePoint.hpp"
#include "Space/SpaceRN.hpp"
#include "Space/SpaceShape.hpp"
/*
#include "Interfaces/geoslib_f_swig.h"
#include "Interfaces/ACalculator.hpp"
#include "Interfaces/AParam.hpp"
#include "Interfaces/AVariable.hpp"
#include "Interfaces/AVariableTemplate.hpp"
#include "Interfaces/Category.hpp"
#include "Interfaces/Database.hpp"
#include "Interfaces/Dictionary.hpp"
#include "Interfaces/interface_d.hpp"
#include "Interfaces/ParamCSV.hpp"
#include "Interfaces/ParamGrid.hpp"
#include "Interfaces/Param.hpp"
#include "Interfaces/VariableBool.hpp"
#include "Interfaces/VariableCategorical.hpp"
#include "Interfaces/VariableDouble.hpp"
#include "Interfaces/VariableInt.hpp"
#include "Interfaces/VariableString.hpp"
*/
#include "Mesh/AMesh.hpp"
#include "Mesh/MeshFactory.hpp"
#include "Mesh/MeshEStandard.hpp"
#include "Mesh/MeshETurbo.hpp"

#include "Enum/AEnum.hpp"

#include "Polynomials/Hermite.hpp"
#include "Polynomials/MonteCarlo.hpp"

#include "LinearOp/ALinearOp.hpp"
#include "LinearOp/ALinearOpMulti.hpp"
#include "LinearOp/ShiftOpCs.hpp"
#include "LinearOp/PrecisionOp.hpp"
#include "LinearOp/PrecisionOpCs.hpp"
#include "LinearOp/TurboOptimizer.hpp"
#include "LinearOp/IProjMatrix.hpp"
#include "LinearOp/ProjMatrix.hpp"
#include "LinearOp/PrecisionOpMultiConditional.hpp"
#include "LinearOp/IOptimCost.hpp"
#include "LinearOp/OptimCostBinary.hpp"
#include "LinearOp/OptimCostColored.hpp"
#include "LinearOp/EPowerPT.hpp"

#include "Neigh/ANeighParam.hpp"
#include "Neigh/NeighUnique.hpp"
#include "Neigh/NeighImage.hpp"
#include "Neigh/NeighMoving.hpp"
#include "Neigh/NeighBench.hpp"
#include "Neigh/ENeigh.hpp"
#include "Neigh/NeighWork.hpp"

#include "Variogram/VarioParam.hpp"
#include "Variogram/Vario.hpp"
#include "Variogram/DirParam.hpp"
#include "Variogram/ECalcVario.hpp"

#include "Model/Model.hpp"
#include "Model/ANoStat.hpp"
#include "Model/NoStatArray.hpp"
#include "Model/NoStatFunctional.hpp"
#include "Model/Option_AutoFit.hpp"
#include "Model/Option_VarioFit.hpp"
#include "Model/Constraints.hpp"
#include "Model/ConsItem.hpp"
#include "Model/CovParamId.hpp"
#include "Model/EModelProperty.hpp"
#include "Model/EConsElem.hpp"
#include "Model/EConsType.hpp"
#include "Model/CovParamId.hpp"

#include "Covariances/ACov.hpp"
#include "Covariances/ACovFunc.hpp"
#include "Covariances/ACovAnisoList.hpp"
#include "Covariances/CovAniso.hpp"
#include "Covariances/ACovGradient.hpp"
#include "Covariances/CovLMC.hpp"
#include "Covariances/CovLMCTapering.hpp"
#include "Covariances/CovLMCConvolution.hpp"
#include "Covariances/CovLMCAnamorphosis.hpp"
#include "Covariances/CovLMGradient.hpp"
#include "Covariances/CovContext.hpp"
#include "Covariances/CovCalcMode.hpp"
#include "Covariances/CovBesselJ.hpp"
#include "Covariances/CovBesselK.hpp"
#include "Covariances/CovCauchy.hpp"
#include "Covariances/CovCosExp.hpp"
#include "Covariances/CovCosinus.hpp"
#include "Covariances/CovCubic.hpp"
#include "Covariances/CovExponential.hpp"
#include "Covariances/CovGamma.hpp"
#include "Covariances/CovGaussian.hpp"
#include "Covariances/CovGC1.hpp"
#include "Covariances/CovGC3.hpp"
#include "Covariances/CovGC5.hpp"
#include "Covariances/CovGCspline2.hpp"
#include "Covariances/CovGCspline.hpp"
#include "Covariances/CovLinear.hpp"
#include "Covariances/CovNugget.hpp"
#include "Covariances/CovP8.hpp"
#include "Covariances/CovPenta.hpp"
#include "Covariances/CovPower.hpp"
#include "Covariances/CovReg1D.hpp"
#include "Covariances/CovSincard.hpp"
#include "Covariances/CovSpherical.hpp"
#include "Covariances/CovStable.hpp"
#include "Covariances/CovStorkey.hpp"
#include "Covariances/CovTriangle.hpp"
#include "Covariances/CovWendland1.hpp"
#include "Covariances/CovWendland2.hpp"
#include "Covariances/ECov.hpp"
#include "Covariances/ETape.hpp"
#include "Covariances/EConvType.hpp"
#include "Covariances/EConvDir.hpp"

#include "Drifts/ADrift.hpp"
#include "Drifts/ADriftElem.hpp"
#include "Drifts/DriftList.hpp"
#include "Drifts/Drift1.hpp"
#include "Drifts/DriftF.hpp"
#include "Drifts/DriftFactory.hpp"
#include "Drifts/DriftX.hpp"
#include "Drifts/DriftX2.hpp"
#include "Drifts/DriftX2Y.hpp"
#include "Drifts/DriftX3.hpp"
#include "Drifts/DriftXY.hpp"
#include "Drifts/DriftXY2.hpp"
#include "Drifts/DriftXZ.hpp"
#include "Drifts/DriftY.hpp"
#include "Drifts/DriftY2.hpp"
#include "Drifts/DriftY3.hpp"
#include "Drifts/DriftYZ.hpp"
#include "Drifts/DriftZ.hpp"
#include "Drifts/DriftZ2.hpp"
#include "Drifts/DriftZ3.hpp"
#include "Drifts/EDrift.hpp"

#include "Matrix/AMatrix.hpp"
#include "Matrix/AMatrixSquare.hpp"
#include "Matrix/MatrixRectangular.hpp"
#include "Matrix/MatrixSquareDiagonal.hpp"
#include "Matrix/MatrixSquareDiagonalCst.hpp"
#include "Matrix/MatrixSquareGeneral.hpp"
#include "Matrix/MatrixSquareSymmetric.hpp"

#include "API/SPDE.hpp"
#include "API/PGSSPDE.hpp"
#include "API/ESPDECalcMode.hpp"

#include "Db/Db.hpp"
#include "Db/DbGrid.hpp"
#include "Db/DbStringFormat.hpp"
#include "Db/ELoadBy.hpp"
#include "Db/ELoc.hpp"

#include "Anamorphosis/AAnam.hpp"
#include "Anamorphosis/AnamContinuous.hpp"
#include "Anamorphosis/AnamDiscrete.hpp"
#include "Anamorphosis/AnamUser.hpp"
#include "Anamorphosis/AnamHermite.hpp"
#include "Anamorphosis/AnamEmpirical.hpp"
#include "Anamorphosis/AnamDiscreteDD.hpp"
#include "Anamorphosis/AnamDiscreteIR.hpp"
#include "Anamorphosis/EAnam.hpp"

#include "Gibbs/GibbsMMulti.hpp"
#include "Gibbs/GibbsUMulti.hpp"

#include "Morpho/Morpho.hpp"
#include "Polygon/Polygons.hpp"
#include "Polygon/PolySet.hpp"
#include "Stats/Classical.hpp"
#include "Stats/PCA.hpp"
#include "Stats/PCAStringFormat.hpp"
#include "LithoRule/Rule.hpp"
#include "LithoRule/RuleStringFormat.hpp"
#include "LithoRule/RuleProp.hpp"
#include "LithoRule/ERule.hpp"

#include "Estimation/KrigingSystem.hpp"

#include "OutputFormat/AOF.hpp"
#include "OutputFormat/FileLAS.hpp"
#include "OutputFormat/FileVTK.hpp"
#include "OutputFormat/GridArcGis.hpp"
#include "OutputFormat/GridBmp.hpp"
#include "OutputFormat/GridEclipse.hpp"
#include "OutputFormat/GridF2G.hpp"
#include "OutputFormat/GridIfpEn.hpp"
#include "OutputFormat/GridIrap.hpp"
#include "OutputFormat/GridXYZ.hpp"
#include "OutputFormat/GridZycor.hpp"

#include "segy.h"

// Mask some warning generated by SWIG:
DISABLE_WARNING_DECLARATION_MASKED
DISABLE_WARNING_EXPR_COND_ASSIGNMENT


%}
