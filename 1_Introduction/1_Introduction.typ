#import "@preview/touying:0.4.2": *
#import emoji: *
#import "@preview/ctheorems:1.1.2": *
#show: thmrules

#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let lemma = thmbox("lemma", "Lemma", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))

#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#let s = themes.simple.register()
#let (init, slides, alert, touying-outline) = utils.methods(s)
#show: init

#let (slide, empty-slide) = utils.slides(s)
#show: slides.with(slide-level: 2)

= Introduction to Discrete Fair Division
=== Table of Contents
#touying-outline()

== Motivations
=== Motivations
- People want stuff
- But there is only a finite amount of things
#pause
- This is the fundamental question of economics
	- How do we study the movement of resources within a society?

=== The Computational Problem
- It is a computationally difficult problem to distribute items among people
- How can we guarantee truthfulness in our algorithm? (People may lie about their value of a good)

=== Applications
Variations of this problem have been used for
#columns(2, gutter: 11pt)[
   #set par(justify: true)
	+ Food distribution
		- Indy Hunger Network
		- Foodbank Australia
	+ Computing resources
		- Memory
		- CPU Time
	
	+ Estate Divisions
		- Spliddit

	#image("Indy Hunger Network.png", width:73%)
 ]

== Premise
=== Premise
- How can we allocate a set of goods to a set of people fairly?
- This is surprisingly complicated
	- People may like different goods differently
	- What does fairness even mean?

=== Discrete Setting // Cite survey paper
- We define $N$ (of cardinality $n$) to be the set of agents and $M$ (of cardinality $m$) to be the set of goods. 
- Each $i in N$ is equipped with a valuation function $v_i$, which assigns a positive valuation to each subset of $M$
$ v_i: 2^M -> RR_(>=0) $
- Intuitively, valuation $v_i (emptyset) = 0$ 
- An allocation is a partition of $M$
$ X = <X_1, X_2, ... X_n> $
 - $v_i$ is additive $v_i (A union B) = v_i (A) + v_i (B)$
	//- Several papers have also relaxed this to be monotonic $ v_i (A union {g}) >= v_i (A) $ or submodular

== EF and PROP
=== Notions of Fairness
- Proportionality
	- Each agent believes they receive at least $1/n$ of the goods
$ v_i (X_i) >= 1/n times v_i (M)$
- Envy-Freeness (*EF*)
	- Each agent believes they receive weakly more than the other agents
$ forall_(i,j in N) v_i (X_i) >= v_i (X_j) $

=== Notions of Fairness
#example[In a discrete setting, EF allocations may not always exist
	#proof[
		By counterexample, take 1 good and 2 agents.
		We arbitrarily give agent 1 the good
		 $ v_2 (X_1) > 0  = v_2 (X_2) $
	]
	A similar argument can be applied to proportionality
]

=== 
#lemma[ $"EF" ->  "PROP"$ for additive valuations
	#proof[
		Assume that there is an envy free allocation and non proportional allocation. Every player believes that they have a piece of equal or better value to that of everyone else. Because the $v_i (X_j)$ may have value < 1/n, and there are n player, this means that $v_i (M)$ can be $< v_i (M)$
	]
]

=== Relaxing EF
- Envy Free up to X (EFX)
	- Each agent believes they receive weakly more than the other agents without some good
$ forall_(i, j) forall_(g in X_j) v_i (X_i) >= v_i (X_j \\ {g})  <-> forall_(i, j) v_i (X_i) >= v_i (X_j \\ min(X_j)) $
- It is not clear if EFX allocations exist or can be computed in polynomial time in general // Cite this
	- Several relaxations of EFX have been proposed 

=== Known cases for EFX
- EFX can be computed efficiently for n=2
	- Cut and Choose 
- An algorithm exists to compute an EFX allocation in pseudo polynomial time for n=3 // Cite Chaudary and Akrami 

== Relaxations
=== Relaxing EFX
- Realized valuations
	- Shared valuation function $v$
	- EFX exists and a polynomial time algorithm is known // Make these slides
- EF1
	$ forall_(i, j) exists_(g in X_j) v_i (X_i) >= v_i (X_j \\ {g}) <-> forall_(i, j) v_i (X_i) >= v_i (X_j \\ max(X_j)) $
- $alpha$-EFX
	- $ forall_(i, j) exists_(g in X_j) v_i (X_i) >= alpha times v_i (X_j \\ {g}) $
	- If EFX allocations exist in general, then $alpha=1$

=== Break Time!
==== Let's Cut a Cake
#figure(
	image("cakeImage.png", width:50%)
)
== Other Fairness
=== Maximin Fair Share
- Let $X_n (M)$ be the set of possible allocations of M goods to n agents
- $mu_i^ n (M)$ is one of the partitions which maximizes the least valuable bundle according to $i$
$  mu_i^n (M) = max_(B in X_n (M)) min_(S in B) v_i (S) $ //Cite
- Maximin Share Fair (MMS) allocations do not always exist // Cite

=== Relaxing MMS
- $alpha$-MMS $v_i (X_i)$

=== Pareto Optimality
- An allocation is Pareto Optimal (PO) iff an agent would protest to another allocation
- The allocation $A$ is PO if there is no allocation B such that $v_i (B_i) >= v_i (A_i)$ for all $i$ and one inequality is strict
- A is not _Pareto Dominated_ by another allocation
// Can this be computed efficiently?
// Apparently there are a polynomial number of PO allocations?
// Does EFkX or smth -> PO?

=== MNW
- Maximize the geometric mean of values for agents with positive value
$ (product_i^n v_i (X_i))^(1/n) $
- $"MNW" ->"EF1" and "PO"$
#proof[
	
]
- Can an EF1 and PO allocation be computed in polynomial time?
=== Questions
==== Questions
== Mechanisms
=== Round Robin
- Agents receive their most valued remaining good in a set order until no goods remain.

=== Envy-Cycle Elimination
- Let $G$ be the envy graph on $N$
- $i -->j$ in G iff $v_i (X_i) < v_i (X_j) $
- If a cycle is found, each agent can receive the bundle of the agent they envy in the cycle
- "Rotate" bundles around the cycle

== Results
=== Computing EF1
Round Robin and Envy-Cycle Elimination produce an EF1 Allocation 
#proof[
			
]
=== Computing $1/2$ MMS
Round Robin and Envy-Cycle Elimination produce an EF1 Allocation 
#proof[
			
]
== Conclusion
=== Conclusion
 - Fair division is a wide field with various applications