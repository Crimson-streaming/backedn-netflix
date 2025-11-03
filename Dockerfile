FROM alpine:latest

# Installer les dépendances
RUN apk add --no-cache \
    ca-certificates \
    wget \
    unzip

# Créer le dossier de travail
WORKDIR /app

# Télécharger PocketBase (version Linux pour Render)
RUN wget -q https://github.com/pocketbase/pocketbase/releases/download/v0.26.3/pocketbase_0.26.3_linux_amd64.zip \
    && unzip -q pocketbase_0.26.3_linux_amd64.zip \
    && chmod +x pocketbase \
    && rm pocketbase_0.26.3_linux_amd64.zip

# Créer le dossier pour les données
RUN mkdir -p /app/pb_data

# Exposer le port
EXPOSE 8080

# Commande de démarrage
# Utiliser 0.0.0.0 pour écouter sur toutes les interfaces
# Render gère automatiquement le routage vers le port 8080
CMD sh -c "./pocketbase superuser upsert \"$ADMIN_EMAIL\" \"$ADMIN_PASSWORD\" && ./pocketbase serve --http=0.0.0.0:${PORT:-8080}"