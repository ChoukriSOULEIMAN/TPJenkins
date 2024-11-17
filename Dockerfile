# Utiliser une image de base Python alpine
FROM python:3.13.0-alpine3.20

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier sum.py dans le conteneur
COPY sum.py /app/sum.py

# Rendre le script exécutable
ENTRYPOINT ["python", "/app/sum.py"]


# Commande par défaut pour garder le conteneur actif
CMD ["tail", "-f", "/dev/null"]