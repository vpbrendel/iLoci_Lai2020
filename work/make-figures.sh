mkdir figures

jupyter nbconvert --to notebook --execute --inplace make-F3a-SF5-SF6.ipynb 
jupyter nbconvert --to notebook --execute --inplace make-F4a-F4b-SF4a.ipynb
jupyter nbconvert --to notebook --execute --inplace make-SF1.ipynb 
jupyter nbconvert --to notebook --execute --inplace \
	--ExecutePreprocessor.timeout=600 make-SF2.ipynb 
jupyter nbconvert --to notebook --execute --inplace make-SF4b.ipynb 
jupyter nbconvert --to notebook --execute --inplace make-SF4c-SF7.ipynb 
jupyter nbconvert --to notebook --execute --inplace make-SF4d.ipynb 


#jupyter nbconvert --to notebook --execute --inplace --ExecutePreprocessor.timeout=600 make-SF1.ipynb 
