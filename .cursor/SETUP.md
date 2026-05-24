# Configuration GitBook + Cursor — VOID RP

Ce dépôt est prêt pour éditer la documentation VOID RP dans Cursor et la publier sur GitBook.

## Ce qui est déjà configuré

- Structure GitBook (`README.md`, `SUMMARY.md`, `.gitbook.yaml`)
- `skill.md` — référence syntaxe GitBook pour l'IA
- Serveur MCP GitBook (39 outils API) dans `.cursor/mcp.json`
- Règle Cursor pour les fichiers Markdown

## 1. Token API GitBook (MCP)

1. Ouvrez [GitBook Developer Settings](https://app.gitbook.com/account/developer)
2. Créez un **Personal Access Token**
3. Copiez `.env.example` vers `.env` :

```powershell
Copy-Item .env.example .env
```

4. Collez le token dans `.env` :

```env
GITBOOK_API_TOKEN=gb_api_votre_token
GITBOOK_DEFAULT_SPACE_ID=votre_space_id   # optionnel
```

5. Installez le serveur MCP (si pas déjà fait) :

```powershell
.\scripts\setup.ps1
```

6. **Redémarrez Cursor** pour charger le serveur MCP `gitbook`

## 2. Git Sync (publication automatique)

C'est la méthode principale pour modifier le site web depuis Cursor.

### Côté GitHub

Le dépôt GitHub associé à ce projet doit être connecté à GitBook. Si ce n'est pas encore fait :

```powershell
git remote add origin https://github.com/assanleleh/GitBookVOIDRP.git
git push -u origin main
```

### Côté GitBook

1. Ouvrez votre espace GitBook VOID RP
2. **Configure** (en haut à droite) → **Git Sync**
3. Choisissez **GitHub** et authentifiez-vous
4. Liez le dépôt `assanleleh/GitBookVOIDRP`
5. Branche : `main`
6. Répertoire projet : `/` (racine)

### Workflow quotidien

```
Cursor (édition .md) → git commit → git push → GitHub → Git Sync → site GitBook
```

## 3. Utiliser le MCP dans Cursor

Une fois le token configuré, demandez par exemple :

- « Liste les pages de mon espace GitBook »
- « Crée une change request pour mettre à jour la page règlement »
- « Importe ce markdown dans la page X »

## 4. MCP lecture seule (site publié)

Si votre site est déjà publié, GitBook expose aussi un MCP en lecture seule :

```
https://VOTRE-SITE.gitbook.io/~gitbook/mcp
```

Utile pour interroger la doc publiée, mais pas pour la modifier.

## Dépannage

| Problème | Solution |
|----------|----------|
| MCP gitbook absent dans Cursor | Redémarrer Cursor après `setup.ps1` |
| Erreur token | Vérifier `.env` et le token sur app.gitbook.com |
| Site non mis à jour | Vérifier que Git Sync est actif et que le push a réussi |
| SUMMARY.md désynchronisé | GitBook le régénère parfois ; alignez-le avec la navigation |

## Liens utiles

- [Git Sync — documentation GitBook](https://gitbook.com/docs/getting-started/git-sync)
- [API GitBook](https://gitbook.com/docs/developers/gitbook-api/api-reference)
- [gitbook-mcp](https://github.com/lucasbenevinuto/gitbook-mcp)
