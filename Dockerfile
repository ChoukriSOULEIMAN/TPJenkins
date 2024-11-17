# Utiliser une image Python légère
FROM python:3.13.0-alpine3.20

# Définir le répertoire de travail
WORKDIR /app

# Copier le script Python et le fichier de test dans le conteneur
COPY sum.py /app/sum.py
COPY teste_variables.txt /app/teste_variables.txt

# Définir la commande par défaut
CMD ["python", "/app/sum.py"]
