Getting Started with LibStructural
==================================

The following examples demonstrate how to load a biochemical reaction network in to LibStructural API for analyzing the stoichiometry matrix. A model should be available at least in one of the following formats: SBML model file (.xml format), a 2D array matrix or a string of SBML file.

----------------------
Testing LibStructural
----------------------
To test the imported structural module, you can use the **test()** method. This will print out an analysis summary of a Glycolysis/Gluconeogenesis SBML model (`BMID000000101155 <https://www.ebi.ac.uk/biomodels-main/BMID000000101155>`_) distributed with LibStructural.

.. code:: python

  import structural
  ls = structural.LibStructural()
  ls.test()

.. end

The following sections describe different ways of loading a model into Libstructural. Once a model is loaded it will automatically call ``analyzeWithQR``. At this point a summary of the analysis can be obtained by calling **getSummary()**:

.. code:: python

  ls.getSummary()

.. end

-------------------------
Loading a model
-------------------------

To load a model in to LibStructural, an instance variable must be created.

.. code:: python

    import structural
    ls = structural.LibStructural()

.. end

Loading a model from a file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A model can be loaded from an SBML file with a .xml format.

.. code:: python

    ls.loadSBMLFromFile("C:\Users\yosef\Documents\SBML_models\iYO844.xml") # This calls the analyzeWithQR implicitly.

.. end

Loading a model from a string
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It is also possible to load a model from an SBML string:

.. code:: python

    ls.loadSBMLFromString("example_SBMLstring")

.. end


Loading a model from a stoichiometric matrix
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: python

    ls = structural.LibStructural()
    matrix = [[  1, -1, -1], [  0, -1,  1], [  0,  1, -1]] # matrix can be a numpy 2d array
    ls.loadStoichiometryMatrix(matrix)

.. end

The load command will also by default add reaction ids of the form _Jx and species ids of the form Sx. To override these default names, see section below.

Assigning Reaction and Species Ids
----------------------------------

When loading a model from a stoichiometry matrix, a label can be added to reactions and species.

.. code:: python

  import structural
  ls = structural.LibStructural()
  matrix = [[  1, -1, -1], [  0, -1,  1], [  0,  1, -1]] # matrix can be a numpy 2d array

  print ls.getStoichiometryMatrix()
  print ls.getSpeciesIds()
  print ls.getReactionsIds()

  print('\n\n')

  # load Ids
  ls.loadSpeciesIdsWithValues (['a', 'b', 'c'], [0, 0, 0]) # The array length for both ids list and values list should be equal to the number of species
  ls.loadReactionIdsWithValues (['F1', 'F2', 'F3'],[0, 0, 0])

  ls.analyzeWithQR()

  print ls.getSpeciesIds()
  print ls.getReactionsIds()

.. end

Loading a model using the antimony model description language
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


If you use `tellurium <http://tellurium.analogmachine.org/>`_ you can load a model by converting an antimony string to SBML string.

.. code:: python

  import structural
  import tellurium as te

  r = te.loada('''
      model Test_Model ()
      species S1, S2, S3;

      // Reactions:
      J1: S1 -> S2; v;
      J2: -> S3; v;
      J3: S3 -> S1; v;

      S1 = 10; S2 = 10; S3 = 10;
      v = 0;

  end

  ''')

  sbmlstr = r.getSBML() # this creates an SBML string from the antimony model, r.
  ls = structural.LibStructural()
  ls.loadSBMLFromString(sbmlstr)
  print(ls.getSummary())

  # an antimony model can be converted in to SBML file as well
  r.exportToSBML('Test_model.xml') # creates an xml file in the current directory
  ls = structural.LibStructural()
  ls.loadSBMLFromFile('Test_model.xml') # loads the xml file from the current directory
  print(ls.getSummary())
.. end

-------------------------
Structural Analysis
-------------------------

The following snippets show some of LibStructural's methods on a model generated using antimony model description language. Below is the network image:

.. figure:: example_model_1.png
    :align: center
    :figclass: align-center
    :scale: 25 %

.. code:: python

  import structural
  import tellurium as te

  r = te.loada('''

      // Reactions:
      J1: ES -> S1 + E; v;
      J2: S2 + E -> ES; v;
      J3: S1 -> S2; v;

      // Species Initialization
      S1 = 10; S2 = 10; ES = 10; E = 10;
      v = 0;

  end

  ''')

  sbmlstr = r.getSBML() # this creates an SBML string from the antimony model, r.
  ls = structural.LibStructural()
  ls.loadSBMLFromString(sbmlstr)

.. end


Once the model is loaded we can run some methods.

.. code:: python
  print(ls.validateStructuralMatrices()) # Prints out if the model is passed some internal structural validation tests.

  # see what tests were run, call ls.getTestDetails()
  tests = ls.getTestDetails()
  print(tests)

.. end

To get the model's default stoichiometry matrix structures run:

.. code:: python

  # get the default, unaltered stoichiometric matrix
  ls.getStoichiometryMatrix()

.. end

A stoichiometry matrix can be converted into a reordered matrix in which the rows are partitioned into N0 (linearly dependent rows) and Nr (linearly independent rows/reduced stoichiometry matrix). Dependent rows will be located on the top and independent rows will at the bottom.

.. code:: python

  # get a row reordered matrix (into dependent and independent rows)
  ls.getReorderedStoichiometryMatrix()

.. end

A fully reordered stoichiometry matrix is a matrix where the Nr section of the reordered stoichiometry matrix partitioned in to NDC (linearly dependent columns) and NIC (linearly independent columns).

.. code:: python

  # get a column and row reordered stoichiometry matrix, run:
  ls.getFullyReorderedStoichiometryMatrix()

.. end

.. figure:: FullReorderedMatrix.PNG
    :align: center
    :figclass: align-center
    :scale: 50 %

.. code:: python

  # get the number NIC and NDC matrices
  ls.getNDCMatrix()
  ls.getNICMatrix() # NIC matrix is always a square matrix

  # get N0 and Nr matrices
  ls.getDependentReactionIds()

  # identify independent reactions (run respective methods for species)
  ls.getIndependentReactionIds()

.. end

We can also get species and reaction information from the model.

.. code:: python

  # get the number of dependent reactions (run respective methods for species)
  ls.getNumDepReactions()
  ls.getNumIndReactions()

  # identify dependent reactions (run respective methods for species)
  ls.getDependentReactionIds()

  # identify independent reactions (run respective methods for species)
  ls.getIndependentReactionIds()

.. end

There are a few methods that compute the conservational analysis of a model.

.. code:: python

  # get the conservational matrix
  ls.getGammaMatrix()

  # get which species are contained in each conserved matrix
  ls.getGammaMatrixIds()

  # get conserved laws and the conserved sums associated with them
  ls.getConservedLaws()



.. end
