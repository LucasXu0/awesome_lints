# DCM Common Lint Rules Reference

This document lists all 331 common lint rules available in DCM (Dart Code Metrics) that can be implemented for Dart/Flutter projects.

**Source:** [DCM Rules Documentation](https://dcm.dev/docs/rules/#common)

**Last Updated:** 2025-12-18

---

## Complete List of Common Rules

### A

1. arguments-ordering
2. avoid-accessing-collections-by-constant-index
3. avoid-accessing-other-classes-private-members
4. avoid-adjacent-strings
5. avoid-always-null-parameters
6. avoid-assigning-to-static-field
7. avoid-assignments-as-conditions
8. avoid-async-call-in-sync-function
9. avoid-banned-annotations
10. avoid-banned-exports
11. avoid-banned-file-names
12. avoid-banned-imports
13. avoid-banned-names
14. avoid-banned-types
15. avoid-barrel-files
16. avoid-bitwise-operators-with-booleans
17. avoid-bottom-type-in-patterns
18. avoid-bottom-type-in-records
19. avoid-cascade-after-if-null
20. avoid-casting-to-extension-type
21. avoid-collapsible-if
22. avoid-collection-equality-checks
23. avoid-collection-methods-with-unrelated-types
24. avoid-collection-mutating-methods
25. avoid-commented-out-code
26. avoid-complex-arithmetic-expressions
27. avoid-complex-conditions
28. avoid-complex-loop-conditions
29. avoid-conditions-with-boolean-literals
30. avoid-constant-assert-conditions
31. avoid-constant-conditions
32. avoid-constant-switches
33. avoid-continue
34. avoid-contradictory-expressions
35. avoid-declaring-call-method
36. avoid-default-tostring
37. avoid-deprecated-usage
38. avoid-double-slash-imports
39. avoid-duplicate-cascades
40. avoid-duplicate-collection-elements
41. avoid-duplicate-constant-values
42. avoid-duplicate-exports
43. avoid-duplicate-initializers
44. avoid-duplicate-map-keys
45. avoid-duplicate-mixins
46. avoid-duplicate-named-imports
47. avoid-duplicate-patterns
48. avoid-duplicate-switch-case-conditions
49. avoid-duplicate-test-assertions
50. avoid-dynamic
51. avoid-empty-spread
52. avoid-empty-test-groups
53. avoid-enum-values-by-index
54. avoid-equal-expressions
55. avoid-excessive-expressions
56. avoid-explicit-pattern-field-name
57. avoid-explicit-type-declaration
58. avoid-extensions-on-records
59. avoid-function-type-in-records
60. avoid-future-ignore
61. avoid-future-tostring
62. avoid-generics-shadowing
63. avoid-getter-prefix
64. avoid-global-state
65. avoid-high-cyclomatic-complexity
66. avoid-identical-exception-handling-blocks
67. avoid-if-with-many-branches
68. avoid-ignoring-return-values
69. avoid-immediately-invoked-functions
70. avoid-implicitly-nullable-extension-types
71. avoid-importing-entrypoint-exports
72. avoid-inconsistent-digit-separators
73. avoid-incorrect-uri
74. avoid-inferrable-type-arguments
75. avoid-inverted-boolean-checks
76. avoid-keywords-in-wildcard-pattern
77. avoid-late-final-reassignment
78. avoid-late-keyword
79. avoid-local-functions
80. avoid-long-functions
81. avoid-long-files
82. avoid-long-parameter-list
83. avoid-long-records
84. avoid-map-keys-contains
85. avoid-missed-calls
86. avoid-missing-completer-stack-trace
87. avoid-missing-enum-constant-in-map
88. avoid-missing-interpolation
89. avoid-missing-test-files
90. avoid-misused-test-matchers
91. avoid-misused-set-literals
92. avoid-misused-wildcard-pattern
93. avoid-mixing-named-and-positional-fields
94. avoid-multi-assignment
95. avoid-mutating-parameters
96. avoid-negated-conditions
97. avoid-negations-in-equality-checks
98. avoid-nested-assignments
99. avoid-nested-conditional-expressions
100. avoid-nested-extension-types
101. avoid-nested-futures
102. avoid-nested-records
103. avoid-nested-shorthands
104. avoid-nested-streams-and-futures
105. avoid-nested-switch-expressions
106. avoid-nested-switches
107. avoid-nested-try-statements
108. avoid-never-passed-parameters
109. avoid-non-ascii-symbols
110. avoid-non-empty-constructor-bodies
111. avoid-non-final-exception-class-fields
112. avoid-non-null-assertion
113. avoid-not-encodable-in-to-json
114. avoid-nullable-interpolation
115. avoid-nullable-parameters-with-default-values
116. avoid-nullable-tostring
117. avoid-one-field-records
118. avoid-only-rethrow
119. avoid-passing-async-when-sync-expected
120. avoid-passing-default-values
121. avoid-passing-self-as-argument
122. avoid-positional-record-field-access
123. avoid-recursive-calls
124. avoid-recursive-tostring
125. avoid-redundant-async
126. avoid-redundant-else
127. avoid-redundant-positional-field-name
128. avoid-redundant-pragma-inline
129. avoid-referencing-discarded-variables
130. avoid-referencing-subclasses
131. avoid-renaming-representation-getters
132. avoid-returning-cascades
133. avoid-returning-void
134. avoid-self-assignment
135. avoid-self-compare
136. avoid-shadowed-extension-methods
137. avoid-shadowing
138. avoid-similar-names
139. avoid-single-field-destructuring
140. avoid-slow-collection-methods
141. avoid-stream-tostring
142. avoid-substring
143. avoid-suspicious-global-reference
144. avoid-suspicious-super-overrides
145. avoid-throw-in-catch-block
146. avoid-throw-objects-without-tostring
147. avoid-top-level-members-in-tests
148. avoid-type-casts
149. avoid-unassigned-fields
150. avoid-unassigned-late-fields
151. avoid-unassigned-stream-subscriptions
152. avoid-uncaught-future-errors
153. avoid-unconditional-break
154. avoid-unknown-pragma
155. avoid-unnecessary-block
156. avoid-unnecessary-call
157. avoid-unnecessary-collections
158. avoid-unnecessary-compare-to
159. avoid-unnecessary-conditionals
160. avoid-unnecessary-constructor
161. avoid-unnecessary-continue
162. avoid-unnecessary-digit-separators
163. avoid-unnecessary-enum-arguments
164. avoid-unnecessary-enum-prefix
165. avoid-unnecessary-extends
166. avoid-unnecessary-futures
167. avoid-unnecessary-getter
168. avoid-unnecessary-if
169. avoid-unnecessary-late-fields
170. avoid-unnecessary-length-check
171. avoid-unnecessary-local-late
172. avoid-unnecessary-local-variable
173. avoid-unnecessary-negations
174. avoid-unnecessary-null-aware-elements
175. avoid-unnecessary-nullable-fields
176. avoid-unnecessary-nullable-parameters
177. avoid-unnecessary-nullable-return-type
178. avoid-unnecessary-overrides
179. avoid-unnecessary-patterns
180. avoid-unnecessary-reassignment
181. avoid-unnecessary-return
182. avoid-unnecessary-statements
183. avoid-unnecessary-super
184. avoid-unnecessary-type-assertions
185. avoid-unnecessary-type-casts
186. avoid-unreachable-for-loop
187. avoid-unrelated-type-assertions
188. avoid-unrelated-type-casts
189. avoid-unremovable-callbacks-in-listeners
190. avoid-unsafe-collection-methods
191. avoid-unsafe-reduce
192. avoid-unused-after-null-check
193. avoid-unused-assignment
194. avoid-unused-generics
195. avoid-unused-instances
196. avoid-unused-local-variable
197. avoid-unused-parameters
198. avoid-weak-cryptographic-algorithms
199. avoid-wildcard-cases-with-enums
200. avoid-wildcard-cases-with-sealed-classes

### B-D

201. banned-usage
202. binary-expression-operand-order
203. dispose-class-fields
204. double-literal-format

### E-H

205. enum-constants-ordering
206. format-comment
207. format-test-name
208. function-always-returns-null
209. function-always-returns-same-value
210. handle-throwing-invocations

### M

211. map-keys-ordering
212. match-base-class-default-value
213. match-class-name-pattern
214. match-getter-setter-field-names
215. match-lib-folder-structure
216. match-positional-field-names-on-assignment
217. max-imports
218. member-ordering
219. missing-test-assertion
220. missing-use-result-annotation
221. move-records-to-typedefs
222. move-variable-closer-to-its-usage
223. move-variable-outside-iteration

### N

224. newline-before-case
225. newline-before-constructor
226. newline-before-method
227. newline-before-return
228. no-boolean-literal-compare
229. no-empty-block
230. no-empty-string
231. no-equal-arguments
232. no-equal-conditions
233. no-equal-nested-conditions
234. no-equal-switch-case
235. no-equal-switch-expression-cases
236. no-equal-then-else
237. no-magic-number
238. no-magic-string
239. no-object-declaration

### P

240. parameters-ordering
241. pass-correct-accepted-type
242. pass-optional-argument
243. pattern-fields-ordering
244. prefer-abstract-final-static-class
245. prefer-add-all
246. prefer-addition-subtraction-assignments
247. prefer-any-or-every
248. prefer-assigning-await-expressions
249. prefer-async-await
250. prefer-boolean-prefixes
251. prefer-both-inlining-annotations
252. prefer-bytes-builder
253. prefer-class-destructuring
254. prefer-commenting-analyzer-ignores
255. prefer-commenting-future-delayed
256. prefer-compound-assignment-operators
257. prefer-conditional-expressions
258. prefer-contains
259. prefer-correct-callback-field-name
260. prefer-correct-error-name
261. prefer-correct-for-loop-increment
262. prefer-correct-future-return-type
263. prefer-correct-handler-name
264. prefer-correct-identifier-length
265. prefer-correct-json-casts
266. prefer-correct-setter-parameter-name
267. prefer-correct-stream-return-type
268. prefer-correct-switch-length
269. prefer-correct-test-file-name
270. prefer-correct-throws
271. prefer-correct-type-name
272. prefer-declaring-const-constructor
273. prefer-digit-separators
274. prefer-early-return
275. prefer-enums-by-name
276. prefer-expect-later
277. prefer-explicit-function-type
278. prefer-explicit-parameter-names
279. prefer-explicit-type-arguments
280. prefer-extracting-function-callbacks
281. prefer-first
282. prefer-for-in
283. prefer-getter-over-method
284. prefer-immediate-return
285. prefer-iterable-of
286. prefer-last
287. prefer-match-file-name
288. prefer-moving-to-variable
289. prefer-named-boolean-parameters
290. prefer-named-imports
291. prefer-named-parameters
292. prefer-null-aware-elements
293. prefer-null-aware-spread
294. prefer-overriding-parent-equality
295. prefer-parentheses-with-if-null
296. prefer-prefixed-global-constants
297. prefer-private-extension-type-field
298. prefer-public-exception-classes
299. prefer-pushing-conditional-expressions
300. prefer-redirecting-superclass-constructor
301. prefer-return-await
302. prefer-returning-condition
303. prefer-returning-conditional-expressions
304. prefer-returning-shorthands
305. prefer-shorthands-with-constructors
306. prefer-shorthands-with-enums
307. prefer-shorthands-with-static-fields
308. prefer-simpler-boolean-expressions
309. prefer-simpler-patterns-null-check
310. prefer-single-declaration-per-file
311. prefer-specific-cases-first
312. prefer-specifying-future-value-type
313. prefer-static-class
314. prefer-static-method
315. prefer-switch-expression
316. prefer-switch-with-enums
317. prefer-switch-with-sealed-classes
318. prefer-test-matchers
319. prefer-test-structure
320. prefer-trailing-comma
321. prefer-type-over-var
322. prefer-typedefs-for-callbacks
323. prefer-unique-test-names
324. prefer-unwrapping-future-or
325. prefer-visible-for-testing-on-members
326. prefer-wildcard-pattern

### R-U

327. record-fields-ordering
328. tag-name
329. unnecessary-trailing-comma
330. use-existing-destructuring
331. use-existing-variable

---

## How to Implement

To implement any of these rules in the awesome_lints package:

1. Create a new file: `lib/src/lints/<rule_name>.dart`
2. Implement the `DartLintRule` class
3. Create test fixtures in `test/fixtures/test_project/lib/<rule_name>/`
4. Register the rule in `lib/src/awesome_lints_plugin.dart`
5. Add documentation to `README.md`
6. Run `dart run custom_lint` to verify

For detailed implementation examples, see the existing rules in the repository.

---

## Resources

- **DCM Documentation:** https://dcm.dev/docs/rules
- **DCM Common Rules:** https://dcm.dev/docs/rules/#common
- **Custom Lint Package:** https://pub.dev/packages/custom_lint
- **Custom Lint Builder:** https://pub.dev/packages/custom_lint_builder

---

*Note: This list represents the common rules available in DCM. Not all rules may be applicable or beneficial for every project. Choose rules that align with your project's needs and coding standards.*
