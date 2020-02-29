mkdir figures

jupyter nbconvert --to notebook --execute --inplace make-SF1.ipynb 
jupyter nbconvert --to notebook --execute --inplace make-F3aSF5.ipynb 
jupyter nbconvert --to notebook --execute --inplace make-SF4b.ipynb 


#jupyter nbconvert --to notebook --execute --inplace --ExecutePreprocessor.timeout=600 make-SF1.ipynb 
