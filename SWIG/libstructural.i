%module structural

// #pragma SWIG nowarn=516

%feature("autodoc", "1");
%inline
%{
#include "libstructural.h"
#include "util.h"
#include "libla.h"
#include "libMetaTool4_3.h"

#define SWIG_FILE_WITH_INIT
static PyObject* pNoModelException;  /* add this! */
%}

%rename (_my_getElementaryModes) getElementaryModes;
%rename (_my_loadStoichiometryMatrix) loadStoichiometryMatrix;
%rename (_my_rref) rref;
%rename (_my_rref_FB) rref_FB;
%rename (_my_getEigenValues) getEigenValues;
%rename (_my_getEigenVectors) getEigenVectors;
%rename (_my_getConditionNumber) getConditionNumber;
%rename (_my_getLeftNullSpace) getLeftNullSpace;
%rename (_my_getRightNullSpace) getRightNullSpace;
%rename (_my_getRank) getRank;
%rename (_my_getStoichiometryMatrix) getStoichiometryMatrix;
%rename (_my_getColumnReorderedNrMatrix) getColumnReorderedNrMatrix;
%rename (_my_getFullyReorderedN0StoichiometryMatrix) getFullyReorderedN0StoichiometryMatrix;
%rename (_my_getFullyReorderedNrMatrix) getFullyReorderedNrMatrix;
%rename (_my_getFullyReorderedStoichiometryMatrix) getFullyReorderedStoichiometryMatrix;
%rename (_my_getGammaMatrix) getGammaMatrix;
%rename (_my_getGammaMatrixGJ) getGammaMatrixGJ;
%rename (_my_getK0Matrix) getK0Matrix;
%rename (_my_getKMatrix) getKMatrix;
%rename (_my_getL0Matrix) getL0Matrix;
%rename (_my_getN0Matrix) getN0Matrix;
%rename (_my_getNDCMatrix) getNDCMatrix;
%rename (_my_getNICMatrix) getNICMatrix;
%rename (_my_getNrMatrix) getNrMatrix;
%rename (_my_getReorderedStoichiometryMatrix) getReorderedStoichiometryMatrix;
%rename (_my_getLinkMatrix) getLinkMatrix;
%rename (_my_getRCond) getRCond;

%init %{
    pNoModelException = PyErr_NewException ("_structural.NoModelException", NULL, NULL);
    Py_INCREF (pNoModelException);
    PyModule_AddObject (m, "NoModelException", pNoModelException);
%}

%pythoncode %{
    NoModelException = _structural.NoModelException
%}

%exception {
	 try {
     $action
   } catch (const LIB_LA::ApplicationException& e) {
     SWIG_exception(SWIG_RuntimeError, "app error");
   } catch (LIB_LA::ApplicationException* e) {
		 std::string msg = e->getDetailedMessage();
		 delete e;
   } catch (LIB_LA::NoModelException* e) {
		 std::string msg = e->getMessage();
		 delete e;
	 
     PyErr_SetString (PyExc_Exception, msg.c_str());
	 return NULL;
   } catch (const std::exception& e) {
     SWIG_exception(SWIG_RuntimeError, e.what());
   } catch (...) {
		 SWIG_exception(SWIG_RuntimeError, "Unknown exception");
	 }
}

%include "carrays.i"
%include "typemaps.i"
%include "stl.i"
%include "std_vector.i"
%include "exception.i"
%include "st_docstrings.i"
%include "../include/matrix.h"


%template(StringDouble) std::pair<std::string,double>;
%template(StrDoubleVector) std::vector< std::pair<std::string,double> >;
%template(StringVector) std::vector<std::string>;
%template(DoubleVector) std::vector<double>;
%template(StringVectorx2) std::pair< std::vector<std::string>, std::vector<std::string> >;

//*
%template(DoubleMatrixStringVector) std::pair<LIB_LA::DoubleMatrix*,  std::vector< std::string> >;

// http://swig.10945.n7.nabble.com/replacing-a-real-class-method-with-SWIG-version-td11418.html
%extend LIB_STRUCTURAL::LibStructural {

	std::pair< std::vector<std::string>, std::vector<std::string> > getColumnReorderedNrMatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getColumnReorderedNrMatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

	void loadReactionIds (std::vector<std::string> reactionIds) {
		self->loadReactionIds(reactionIds);
	}

	void loadReactionIdsWithValues (std::vector<std::string> reactionIds, std::vector<double> reactionValues) {
		self->loadReactionIdsWithValues(reactionIds, reactionValues);
	}

	void loadSpeciesIdsWithValues (std::vector<std::string> speciesIds, std::vector<double> speciesValues) {
		self->loadSpeciesIdsWithValues(speciesIds, speciesValues);
	}

	/*void loadSpeciesIds (std::vector<std::string> speciesIds) {
		self->loadSpeciesIds(speciesIds);
	}*/

	std::pair< std::vector<std::string>, std::vector<std::string> > getGammaMatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getGammaMatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

	std::pair< std::vector<std::string>, std::vector<std::string> > getK0MatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getK0MatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

	std::pair< std::vector<std::string>, std::vector<std::string> > getKMatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getKMatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

	std::pair< std::vector<std::string>, std::vector<std::string> > getL0MatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getL0MatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

	std::pair< std::vector<std::string>, std::vector<std::string> > getLinkMatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getLinkMatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

	std::pair< std::vector<std::string>, std::vector<std::string> > getLinkMatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getLinkMatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

	std::pair< std::vector<std::string>, std::vector<std::string> > getN0MatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getN0MatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

	std::pair< std::vector<std::string>, std::vector<std::string> > getNDCMatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getNDCMatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

	std::pair< std::vector<std::string>, std::vector<std::string> > getNICMatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getNICMatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

	std::pair< std::vector<std::string>, std::vector<std::string> > getNrMatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getNrMatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

	std::pair< std::vector<std::string>, std::vector<std::string> > getStoichiometryMatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getStoichiometryMatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

	std::pair< std::vector<std::string>, std::vector<std::string> > getFullyReorderedStoichiometryMatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getFullyReorderedStoichiometryMatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

	std::pair< std::vector<std::string>, std::vector<std::string> > getReorderedStoichiometryMatrixIds() {
		std::vector<std::string> rows;
		std::vector<std::string> cols;
		self->getReorderedStoichiometryMatrixIds(rows, cols);
		return std::make_pair(rows, cols);
	}

%pythoncode %{
	def getStoichiometryMatrix(self):
    """
    LibStructural.getStoichiometryMatrix(self)
    :returns: Unaltered stoichiometry matrix.
    """
    return self._my_getStoichiometryMatrix().toNumpy();


	def getColumnReorderedNrMatrix(self):
		"""
		LibStructural.getColumnReorderedNrMatrix(self)
		:returns: the Nr Matrix repartitioned into NIC (independent columns) and NDC (dependent columns). The Nr matrix contains the independent rows of the stoichiometry matrix
		"""
		return self._my_getColumnReorderedNrMatrix().toNumpy()

	def getFullyReorderedN0StoichiometryMatrix(self):
		"""
		LibStructural.getFullyReorderedN0StoichiometryMatrix(self)

		Computes the N0 matrix if possible. The N0 matrix will contain all the dependent rows of the stoichiometry matrix.

		:returns: the N0 Matrix.

		"""
		return self._my_getFullyReorderedN0StoichiometryMatrix().toNumpy()

	def getFullyReorderedNrMatrix(self):
		"""
		LibStructural.getFullyReorderedNrMatrix(self)

		The Nr matrix contains all the linearly independent rows of the stoichiometry matrix.

		:returns: the Nr Matrix.
		"""
		return self._my_getFullyReorderedNrMatrix().toNumpy()

	def getFullyReorderedStoichiometryMatrix(self):
		"""
		LibStructural.getFullyReorderedStoichiometryMatrix(self)
		:returns: the fully reordered stoichiometry matrix. Rows and columns are reordered so all indepedent rows
		of the stoichiometry matrix are brought to the top and left side of the matrix.
		"""
		return self._my_getFullyReorderedStoichiometryMatrix().toNumpy()

	def getGammaMatrix(self):
		"""
		LibStructural.getGammaMatrix(self)
		:returns: Gamma, the conservation law array.
		Each row represents a single conservation law where the column indicates the participating molecular species.
		The number of rows is therefore equal to the number of conservation laws. Columns are ordered according to the
		rows in the reordered stoichiometry matrix, see ``LibStructural.getReorderedSpeciesId`` and ``LibStructural.getReorderedStoichiometryMatrix``.

		"""
		return self._my_getGammaMatrix().toNumpy()

	def getGammaMatrixGJ(self, oMatrix):
		"""
		LibStructural.getGammaMatrixGJ(self,matrix)

		:param: the stoichiometry matrix that will be used to calculate gamma
		:returns: Gamma, the conservation law array.

		Each row represents a single conservation law where the column indicate the participating molecular species. The number of rows is therefore equal to the number of conservation laws.
		In this case the Gamma Matrix is recalculated for the given stoichiometry matrix. amma is calculated based on R = GaussJordan ( [ stoichiometry  I ] ), where R has the form

		R = [ R11 R12
				0  GAMMA ]

		The RowIds should be an increasing number, to enumerate the conservation law, the column label will be the same label as the stoichiometry matrix.
		"""
		import numpy as np

		if (type(oMatrix) is list or type(oMatrix) is np.ndarray):
			oMatrix = np.array(oMatrix)
			if oMatrix.ndim == 2:
				rows = len(oMatrix)
				cols = len(oMatrix[0])
				m = DoubleMatrix(rows,cols)
				for i in range(rows):
					for j in range (cols):
						m.set (i, j, oMatrix[i][j])
				return self._my_getGammaMatrixGJ(m).toNumpy()
			else:
				raise ValueError("Expecting 2 dimensional list or numpy array")
		else:
			raise ValueError("Expecting list or numpy array")


	def getK0Matrix(self):
		"""
		LibStructural.getK0Matrix(self)

		:returns: the K0 Matrix.
		K0 is defined such that K0 = -(NIC)\ :sup:`-1`\ * NDC, or equivalently, [NDC NIC][I K0]' = 0 where [NDC NIC] = Nr
		"""
		return self._my_getK0Matrix().toNumpy()

	def getKMatrix(self):
		"""
		LibStructural.getKMatrix(self)
		:returns: the K matrix (right nullspace of Nr)
		The K matrix has the structure, [I K0]'
		"""
		return self._my_getKMatrix().toNumpy()

	def getL0Matrix(self):
		"""
		LibStructural.getL0Matrix(self)

		:returns: the L0 Matrix.

		L0 is defined such that  L0*Nr = N0. L0 forms part of the link matrix, L.  N0 is the set of linear dependent rows from the lower portion of the reordered stoichiometry matrix.

		"""
		return self._my_getL0Matrix().toNumpy()

	def getLinkMatrix(self):
		"""
		LibStructural.getLinkMatrix(self)
		:returns: L, the Link Matrix, left nullspace (aka nullspace of the transpose Nr).

		L will have the structure, [I L0]', such that L*Nr = N
		"""
		return self._my_getLinkMatrix().toNumpy()

	def getN0Matrix(self):
		"""
		LibStructural.getN0Matrix(self)
		:returns: the N0 Matrix.
		The N0 matrix is the set of linearly dependent rows of N where L0 Nr = N0.
		"""
		return self._my_getN0Matrix().toNumpy()

	def getNDCMatrix(self):
		"""
		LibStructural.getNDCMatrix(self)
		:returns: the NDC Matrix (the set of linearly dependent columns of Nr).

		"""
		return self._my_getNDCMatrix().toNumpy()

	def getNICMatrix(self):
		"""
		LibStructural.getNICMatrix(self)
		:returns: the NIC Matrix (the set of linearly independent columns of Nr)
		"""
		return self._my_getNICMatrix().toNumpy()

	def getNrMatrix(self):
		"""
		LibStructural.getNrMatrix(self)

		:returns: the Nr Matrix.

		The rows of the Nr matrix will be linearly independent.
		"""
		return self._my_getNrMatrix().toNumpy()

	def getReorderedStoichiometryMatrix(self):
		"""
		LibStructural.getReorderedStoichiometryMatrix(self)

		:returns: the reordered stoichiometry matrix (row reordered stoichiometry matrix, columns are not reordered!)

		"""
		return self._my_getReorderedStoichiometryMatrix().toNumpy()

	def loadStoichiometryMatrix(self, data):
			"""
			LibStructural.loadStoichiometryMatrix(self, Matrix)

			:param: 2D array stoichiometry matrix

			Loads a stoichiometry matrix into the library.
			To analyze the stoichiometry call one of the following:

			| ``LibStructural.analyzeWithQR``,
			| ``LibStructural.analyzeWithLU``,
			| ``LibStructural.analyzeWithLUandRunTests``,
			| ``LibStructural.analyzeWithFullyPivotedLU``,
			| ``LibStructural.analyzeWithFullyPivotedLUwithTests``,

			Remarks: if matrix ids are needed it is recommended to call LibStructural.loadSpeciesIds
			and ``LibStructural.loadReactionIds``after a call to this method.

			"""
			import numpy as np

			if (type(data) is list or type(data) is np.ndarray):
				data = np.array(data)
				if data.ndim == 2:
					rows = len(data)
					cols = len(data[0])
					m = DoubleMatrix(rows,cols)
					for i in range(rows):
						for j in range (cols):
							m.set (i, j, data[i][j])
					return self._my_loadStoichiometryMatrix (m)
				else:
					raise ValueError("Expecting 2 dimensional list or numpy array")
			else:
				raise ValueError("Expecting list or numpy array")

	def getElementaryModes (self):
	    """
	    Returns the list of elementary modes are rows in a matrix
	    """
	    import numpy as np
		   
	    return self._my_getElementaryModes().toNumpy()

	def rref(self, data, tolerance=1e-6):
			"""
			LibStructural.rref(self, matrix, tol)

      Computes the reduced row echelon of the given matrix. Tolerance is set to indicate the smallest number consider to be zero.

			:param: a matrix (numpy)
			:param: Optional: tolerance (double), default is 1E-6
			:returns: reduced row echelon form of the matrix
			"""
			import numpy as np

			if (type(data) is list or type(data) is np.ndarray):
				data = np.array(data)
				if data.ndim == 2:
					rows = len(data)
					cols = len(data[0])
					m = DoubleMatrix(rows,cols)
					for i in range(rows):
						for j in range (cols):
							m.set (i, j, data[i][j])
					return self._my_rref (m, tolerance).toNumpy()
				else:
					raise ValueError("Expecting 2 dimensional list or numpy array")
			else:
  		        raise ValueError("Expecting list or numpy array")

	def rref_FB(self, data, tolerance=1e-6):
			"""
			LibStructural.getEigenValues(self, matrix)

			:param: Matrix to find the refuced row echelon for.
			:returns: the reduce row echelon.
			"""

			import numpy as np

			if (type(data) is list or type(data) is np.ndarray):
				data = np.array(data)
				if data.ndim == 2:
					rows = len(data)
					cols = len(data[0])
					m = DoubleMatrix(rows,cols)
					for i in range(rows):
						for j in range (cols):
							m.set (i, j, data[i][j])
					return self._my_rref_FB (m, tolerance).toNumpy()
				else:
					raise ValueError("Expecting 2 dimensional list or numpy array")
			else:
  		        raise ValueError("Expecting list or numpy array")

	def getEigenValues (self, oMatrix):
			"""
			LibStructural.getEigenValues(self, matrix)

			:param: Matrix to find the eigenvalues for.
			:returns: an array, first column are the real values and second column are imaginary values
			"""

			import numpy as np

			if (type(oMatrix) is list or type(oMatrix) is np.ndarray):
				oMatrix = np.array(oMatrix)
				if oMatrix.ndim == 2:
					rows = len(oMatrix)
					cols = len(oMatrix[0])
					m = DoubleMatrix(rows,cols)
					for i in range(rows):
						for j in range (cols):
							m.set (i, j, oMatrix[i][j])
					return self._my_getEigenValues(m).toNumpy()
				else:
					raise ValueError("Expecting 2 dimensional list or numpy array")
			else:
  		        raise ValueError("Expecting list or numpy array")

	def getEigenVectors (self, oMatrix):
			"""
			LibStructural.getEigenVectors(self, matrix)

			:param: Matrix to find the eigenvectors for
			:returns: an array where each columns is an eigenvector
			"""

			import numpy as np

			if (type(oMatrix) is list or type(oMatrix) is np.ndarray):
				oMatrix = np.array(oMatrix)
				if oMatrix.ndim == 2:
					rows = len(oMatrix)
					cols = len(oMatrix[0])
					m = DoubleMatrix(rows,cols)
					for i in range(rows):
						for j in range (cols):
							m.set (i, j, oMatrix[i][j])
					return self._my_getEigenVectors(m).toNumpy()
				else:
					raise ValueError("Expecting 2 dimensional list or numpy array")
			else:
  		        raise ValueError("Expecting list or numpy array")

	def getConditionNumber (self, oMatrix):
			'''
			LibStructural.getConditionNumber(self, matrix)

			:param: Takes a matrix (numpy) as an argument. Find the condition number of the matrix.
			:returns: the condition number
			'''
			import numpy as np

			if (type(oMatrix) is list or type(oMatrix) is np.ndarray):
				oMatrix = np.array(oMatrix)
				if oMatrix.ndim == 2:
					rows = len(oMatrix)
					cols = len(oMatrix[0])
					m = DoubleMatrix(rows,cols)
					for i in range(rows):
						for j in range (cols):
							m.set (i, j, oMatrix[i][j])
					return self._my_getConditionNumber(m)
				else:
					raise ValueError("Expecting 2 dimensional list or numpy array")
			else:
  		        raise ValueError("Expecting list or numpy array")

	def getRConditionNumber (self, oMatrix):
			'''
			LibStructural.getRConditionNumber(self, matrix)

			:param: Takes a matrix (numpy) as an argument. Find the condition number of the matrix.
			:returns: the condition number
			'''

			import numpy as np

			if (type(oMatrix) is list or type(oMatrix) is np.ndarray):
				oMatrix = np.array(oMatrix)
				if oMatrix.ndim == 2:
					rows = len(oMatrix)
					cols = len(oMatrix[0])
					m = DoubleMatrix(rows,cols)
					for i in range(rows):
						for j in range (cols):
							m.set (i, j, oMatrix[i][j])
					return self._my_getRCond(m)
				else:
					raise ValueError("Expecting 2 dimensional list or numpy array")
			else:
  		        raise ValueError("Expecting list or numpy array")

	def getLeftNullSpace (self, oMatrix):
			"""
			LibStructural.getConditionNumber(self, matrix)

			:param: Matrix to find the left nullspace of.
			:returns: the Left Nullspace of the matrix argument.

			"""

			import numpy as np

			if (type(oMatrix) is list or type(oMatrix) is np.ndarray):
				oMatrix = np.array(oMatrix)
				if oMatrix.ndim == 2:
					rows = len(oMatrix)
					cols = len(oMatrix[0])
					m = DoubleMatrix(rows,cols)
					for i in range(rows):
						for j in range (cols):
							m.set (i, j, oMatrix[i][j])
					return self._my_getLeftNullSpace(m).toNumpy()
				else:
					raise ValueError("Expecting 2 dimensional list or numpy array")
			else:
  		        raise ValueError("Expecting list or numpy array")

	def getRightNullSpace (self, oMatrix):
			"""
			LibStructural.getRightNullSpace(self, matrix)

			:param: Matrix to find the right nullspace of.
			:returns: the Right Nullspace of the matric argument.
			"""

			import numpy as np

			if (type(oMatrix) is list or type(oMatrix) is np.ndarray):
				oMatrix = np.array(oMatrix)
				if oMatrix.ndim == 2:
					rows = len(oMatrix)
					cols = len(oMatrix[0])
					m = DoubleMatrix(rows,cols)
					for i in range(rows):
						for j in range (cols):
							m.set (i, j, oMatrix[i][j])
					return self._my_getRightNullSpace(m).toNumpy()
				else:
					raise ValueError("Expecting 2 dimensional list or numpy array")
			else:
  		        raise ValueError("Expecting list or numpy array")

	def getRank (self, oMatrix):
			"""
			LibStructural.getRank(self, matrix)

			:param: Matrix to find the rank of.
			:returns: the rank as an integer.
			"""
			import numpy as np

			if (type(oMatrix) is list or type(oMatrix) is np.ndarray):
				oMatrix = np.array(oMatrix)
				if oMatrix.ndim == 2:
					rows = len(oMatrix)
					cols = len(oMatrix[0])
					m = DoubleMatrix(rows,cols)
					for i in range(rows):
						for j in range (cols):
							m.set (i, j, oMatrix[i][j])
					return self._my_getRank(m)
				else:
					raise ValueError("Expecting 2 dimensional list or numpy array")
			else:
  		        raise ValueError("Expecting list or numpy array")

	def test (self):
		import pkg_resources
		model_path = pkg_resources.resource_filename('structural','test/BMID000000101155.xml')
		print(self.loadSBMLFromFile(model_path))
		print('\nValidating structural matrices...\n')
		print(self.getTestDetails())
		print(self.validateStructuralMatrices())
%}

}

%ignore LIB_STRUCTURAL::LibStructural::findPositiveGammaMatrix;
%ignore LIB_STRUCTURAL::LibStructural::getColumnReorderedNrMatrixIds;
%ignore LIB_STRUCTURAL::LibStructural::getGammaMatrixIds;
%ignore LIB_STRUCTURAL::LibStructural::getK0MatrixIds;
%ignore LIB_STRUCTURAL::LibStructural::getKMatrixIds;
%ignore LIB_STRUCTURAL::LibStructural::getL0MatrixIds;
%ignore LIB_STRUCTURAL::LibStructural::getLinkMatrixIds;
%ignore LIB_STRUCTURAL::LibStructural::getN0MatrixIds;
%ignore LIB_STRUCTURAL::LibStructural::getNDCMatrixIds;
%ignore LIB_STRUCTURAL::LibStructural::getNICMatrixIds;
%ignore LIB_STRUCTURAL::LibStructural::getNrMatrixIds;
%ignore LIB_STRUCTURAL::LibStructural::getStoichiometryMatrixIds;
%ignore LIB_STRUCTURAL::LibStructural::getFullyReorderedStoichiometryMatrixIds;
%ignore LIB_STRUCTURAL::LibStructural::getReorderedStoichiometryMatrixIds;
%ignore LIB_STRUCTURAL::_sResultStream;


%include "../include/libstructural.h"
%include "../include/util.h"

%rename(assign) operator=;
%rename(add) operator+;
%rename(sub) operator-;
%rename(div) operator/;
%rename(mult) operator*;
%ignore operator<<;
%ignore operator();
%ignore operator[];

%ignore getReal;
%ignore setReal;
%ignore getImag;
%ignore setImag;



%inline
%{
#include "complex.h"
%}

%array_class(LIB_LA::Complex, complexArray);
%array_class(double, doubleArray);
%array_class(int, intArray);
%array_function(LIB_LA::Complex, complexArray);
%array_function(double, doubleArray);
%array_function(int, intArray);

using LIB_LA::Matrix;

%template(DoubleMatrix) LIB_LA::Matrix<double>;
%template(IntMatrix) LIB_LA::Matrix<int>;
%template(ComplexMatrix) LIB_LA::Matrix<LIB_LA::Complex>;

// #ifdef SWIGCSHARP
// %template(StringDouble) std::pair< std::string, double >;
// %template(StringDoubleVector) std::vector< std::pair< std::string, double > >;
// #endif

%extend LIB_LA::Matrix<double>
{
	virtual double get(const unsigned int row, const unsigned int col)
  {
		return (*self)(row,col);
		//return *(self->_Array + row * self->_Cols + col);
	}

	virtual void set(const unsigned int row, const unsigned int col, double value)
  {
		(*self)(row,col) = value;
	}

%pythoncode %{
		def toNumpy(self):
				import numpy as np
				result = np.zeros((self.numRows(), self.numCols()))
				for i in range(self.numRows()):
						for j in range(self.numCols()):
								result[i,j] = self.get(i,j)
				return result
		def __repr__(self):
				return self.toNumpy().__repr__()
%}

}


%extend LIB_LA::Matrix<int>
{
	virtual int get(const unsigned int row, const unsigned int col)
    {
		return (*self)(row,col);
	}

	virtual void set(const unsigned int row, const unsigned int col, int value)
    {
		(*self)(row,col) = value;
	}

%pythoncode %{
		def toNumpy(self):
				import numpy as np
				result = np.zeros((self.numRows(), self.numCols()), dtype=np.int)
				for i in range(self.numRows()):
						for j in range(self.numCols()):
								result[i,j] = self.get(i,j)
				return result
		def __repr__(self):
				return self.toNumpy().__repr__()
%}
}

%extend LIB_LA::Matrix<LIB_LA::Complex>
{
	virtual LIB_LA::Complex get(const unsigned int row, const unsigned int col)
    {
		return (*self)(row,col);
	}

	virtual double getReal(const unsigned int row, const unsigned int col)
    {
		return (*self)(row,col).Real;
	}
	virtual double getImag(const unsigned int row, const unsigned int col)
    {
		return (*self)(row,col).Imag;
	}

	virtual void set(const unsigned int row, const unsigned int col, LIB_LA::Complex value)
    {
		(*self)(row,col) = value;
	}

	virtual void setReal(const unsigned int row, const unsigned int col, double value)
    {
		(*self)(row,col).Real = value;
	}
	virtual void setImag(const unsigned int row, const unsigned int col, double value)
    {
		(*self)(row,col).Imag = value;
	}

%pythoncode %{
		def toNumpy(self):
				import numpy as np
				result = np.zeros((self.numRows(), self.numCols()), dtype=np.complex_)
				for i in range(self.numRows()):
						for j in range(self.numCols()):
								result[i,j] = self.getReal(i,j) + self.getImag(i,j)*1j
				return result
		def __repr__(self):
				return self.toNumpy().__repr__()
%}
}

// %ignore LIB_STRUCTURAL::LibStructural::getInitialConditions;
// %rename (_getInitialConditions) LIB_STRUCTURAL::LibStructural::getInitialConditions;

/*%extend LIB_STRUCTURAL::LibStructural {
	std::vector< std::pair<std::string, double> > _getInitialConditions() {
		return *self->getInitialConditions();
	}
%pythoncode %{
		def getInitialConditions(*args):
				return _getInitialConditions(*args)
%}
}*/
