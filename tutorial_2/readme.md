Graph Search Tutorial
---------------------
Basically, this tutorial is to learn how to apply graph searching algorithms to a state-space problem defined in prolog. This requires 3 files:

[**General Graph-Search Engine**](ggse.pl)
This file defines our generic graph search algorithm. The search predicate defines how we search through our graph to find a goal state. This file uses predicates defined in our [*graph search algorithm file*](#GSA), as well as some predicates defined in our [*state-space representation*](#SSR)

<a name="GSA"></a>**Graph Search Algorithm**
This file specifies the behaviour of how the GGSE chooses a path and adds new paths to the graph. Currently, I'm using the [*breadth-first GSA*](bf.pl) from the lectures, as it has completeness and optimal properties.

<a name="SSR"></a>**State-Space Representation**
This file contains the state-space representation of a particular problem in prolog. It also defines how we make nodes from a state, and how we find the state of a given node. An example of this is for [*problem 1*](ex_1.pl) of the tutorial.

To test this out, we run the following in swipl:
```
?- consult([ssr, ggse, gsa])
?- search([[initial_state]], SolnPath)
```
Where:
- ssr is the prolog file containing the state space representation
- ggse is the prolog file containing the generic graph search engine
- gsa is the prolog file containing your particular graph search algorithm

