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

== Premise

=== Premise
- How can we allocate a set of goods to a set of people fairly?
- This is surprisingly complicated
	- People may like different goods differently
	- What does fairness even mean?

=== Discrete Setting
- We define $N$ to be the set of agents of cardinality $n$ and $M$ to be the set of goods of cardinality $m$. 
- Intuitively, valuations are normalized so that $v_i (emptyset) = 0$ 
- Each $i in N$ is equipped with a valuation function $v_i$, which assigns a positive valuation to each subset of $M$
$ v_i: 2^M -> RR_(>=0) $
#pagebreak()
 - $v_i$ is additive $ v_i (A union B) = v_i (A) + v_i (B) $
	- Several papers have also relaxed this to be monotonic $ v_i (A union {g}) >= v_i (A) $

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
=== Relaxing EF
- Envy Free up to X (EFX)
	- Each agent believes they receive weakly more than the other agents without some good
$ forall_(i, j) forall_(g in X_j) v_i (X_i) >= v_i (X_j \\ {g})  <-> forall_(i, j) v_i (X_i) >= v_i (X_j \\ min(X_j))$
- It is not clear if EFX allocations exist or can be computed in polynomial time in general // Cite this
	- Several relaxations of EFX have been proposed 

=== Known cases for EFX
- EFX can be computed efficiently for n=2
	- Cut and Choose 
- EFX can be computed in pseudo polynomial time for n=3 // Cite Chaudary and Akrami 

=== Relaxing EFX
- Realized valuations
	- Shared valuation function $v$
- EF1
	$ forall_(i, j) exists_(g in X_j) v_i (X_i) >= v_i (X_j \\ {g}) <-> forall_(i, j) v_i (X_i) >= v_i (X_j \\ max(X_j)) $
- $alpha$-EFX
	- $ forall_(i, j) exists_(g in X_j) v_i (X_i) >= alpha times v_i (X_j \\ {g}) $
	- If EFX allocations exist in general, then $alpha=1$
- EFkX
	- 

=== Round Robin

=== Envy-Cycle Elimination

=== Maximin Share

=== Leximin 