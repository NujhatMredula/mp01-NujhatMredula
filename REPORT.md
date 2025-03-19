# MP Report

## Student Information

- Name: Nujhat Alam Mredula
- AID: A20519041

# Machine Problem 1 - Report  

## **Self-Evaluation Checklist**  

Tick the boxes (i.e., fill them with 'X's) that apply to your submission:  

- I successfully implemented and tested the following exercises:  
  - [X] 1 (iexpt)  
  - [X] 2 (poly-eval)  
  - [X] 3 (concatenate)  
  - [X] 4 (merge)  
  - [X] 5 (merge-tail)  
  - [X] 6 (run-length-encode)  
  - [X] 7 (run-length-decode)  
  - [X] 8 (label-sexp)  

## **Summary and Reflection**  

I have implemented all required exercises in `mp1.rkt` and tested them to ensure they function correctly. The solutions are written in a way that follows Racket's functional programming paradigm.  

For **`iexpt`**, I used recursion to compute integer exponentiation efficiently. **`poly-eval`** was implemented to evaluate a polynomial given its coefficients and an input value. **`concatenate`** merges multiple lists, while **`merge`** and **`merge-tail`** combine two sorted lists efficiently. **`run-length-encode`** compresses a list by grouping consecutive duplicates, and **`run-length-decode`** reconstructs the original list from the encoded form. Finally, **`label-sexp`** categorizes symbolic expressions based on their type.  

### **Challenges Faced & Learning Outcomes**  

- Understanding tail recursion was initially challenging, especially for `merge-tail`. However, breaking down the problem into base and recursive cases helped.  
- Debugging recursive functions required careful thought, and using `racket/trace` helped visualize function calls.  
- I gained a deeper understanding of **pattern matching in Racket**, which made `label-sexp` more intuitive to implement.  
- Testing edge cases (e.g., empty lists, large numbers, nested expressions) was crucial to ensuring correctness.  

### **Final Thoughts**  

I enjoyed this assignment because it strengthened my understanding of **functional programming principles** and recursion in Racket. While debugging recursive functions was tricky at times, it was satisfying to see them work correctly after careful implementation.  

---

### ✅ **Next Steps**  
Now, following these steps to submit:  

1. Saving this `REPORT.md` file in my **mp01-NujhatMredula** directory.  
2. Adding and committing the file:  
   ```bash
   git add REPORT.md  
   git commit -m "Added completed REPORT.md"  
   git push origin main  
