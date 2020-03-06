mkdir figures

jupyter nbconvert --to notebook --execute --inplace make-F3aSF5.ipynb 
jupyter nbconvert --to notebook --execute --inplace make-F4aF4bSF4a.ipynb
jupyter nbconvert --to notebook --execute --inplace make-SF1.ipynb 
jupyter nbconvert --to notebook --execute --inplace \
	--ExecutePreprocessor.timeout=600 make-SF2.ipynb 
jupyter nbconvert --to notebook --execute --inplace make-SF4b.ipynb 
jupyter nbconvert --to notebook --execute --inplace make-SF4cSF7.ipynb 
jupyter nbconvert --to notebook --execute --inplace make-SF4d.ipynb 


#jupyter nbconvert --to notebook --execute --inplace --ExecutePreprocessor.timeout=600 make-SF1.ipynb 
