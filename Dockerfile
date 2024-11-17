FROM python:3.9-slim

# Installation des dépendances Python
RUN pip install sphinx

# Copier le script Python dans le conteneur
COPY sum.py /app/sum.py
WORKDIR /app

# Ici nous allons initialiser le projet Sphinx
RUN sphinx-quickstart -q -p "TPJenkins" -a "Auteur" -v "1.0" --sep -r 1.0

# Et enfin installer sphinx-autodoc pour la documentation automatique
RUN pip install sphinx-autodoc-typehints

CMD ["python3", "sum.py"]
