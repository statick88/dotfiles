---
name: monorepo-management
description: >
  Monorepo structure and management with Turborepo, shared packages, and workspace dependencies.
  Trigger: When organizing multi-package projects, sharing code across packages, or scaling development.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Monorepo Structure (Recommended)

```
my-monorepo/
├── package.json          # Root workspace config
├── pnpm-workspace.yaml   # Workspace definition (pnpm)
├── turbo.json           # Turborepo config
├── .github/
│   └── workflows/       # CI/CD for whole repo
├── apps/
│   ├── web/             # Next.js frontend
│   │   ├── package.json
│   │   ├── src/
│   │   └── tsconfig.json
│   ├── mobile/          # React Native or Flutter
│   │   ├── package.json
│   │   └── src/
│   └── api/             # FastAPI/Express backend
│       ├── package.json or requirements.txt
│       └── src/
├── packages/
│   ├── ui/              # Shared UI components
│   │   ├── package.json
│   │   └── src/
│   ├── types/           # Shared TypeScript types
│   │   ├── package.json
│   │   └── src/
│   ├── utils/           # Shared utilities
│   │   ├── package.json
│   │   └── src/
│   ├── database/        # ORM/database layer
│   │   ├── package.json
│   │   └── src/
│   └── auth/            # Authentication logic
│       ├── package.json
│       └── src/
├── shared/
│   ├── config/          # Shared configs
│   │   ├── tsconfig.json
│   │   ├── eslint-config/
│   │   └── prettier-config/
│   └── scripts/         # Shared scripts
└── tools/
    └── ci/              # CI/CD utilities
```

## Root package.json (pnpm Workspaces)

```json
{
  "name": "my-monorepo",
  "version": "1.0.0",
  "private": true,
  "packageManager": "pnpm@9.0.0",
  "scripts": {
    "dev": "turbo dev",
    "build": "turbo build",
    "lint": "turbo lint",
    "test": "turbo test",
    "format": "turbo format",
    "clean": "turbo clean && rm -rf node_modules"
  },
  "devDependencies": {
    "turbo": "^2.0.0",
    "typescript": "^5.0.0",
    "@types/node": "^20.0.0"
  }
}
```

## pnpm-workspace.yaml (Package Manager Config)

```yaml
packages:
  - 'apps/*'
  - 'packages/*'
  - 'tools/*'

# Shared dependencies across packages
overrides:
  typescript: ^5.0.0
  react: ^18.0.0
  react-dom: ^18.0.0
```

## turbo.json (Build Orchestration)

```json
{
  "$schema": "https://turbo.build/schema.json",
  "globalEnv": ["DATABASE_URL", "API_KEY"],
  "globalPassThroughEnv": ["CI", "NODE_ENV"],
  
  "tasks": {
    "dev": {
      "cache": false,
      "interactive": true,
      "dependsOn": []
    },
    
    "build": {
      "outputs": ["dist/**", ".next/**"],
      "cache": true,
      "dependsOn": ["^build"]
    },
    
    "test": {
      "outputs": ["coverage/**"],
      "cache": true,
      "dependsOn": ["build"]
    },
    
    "lint": {
      "cache": true,
      "outputs": [".eslintcache"]
    },
    
    "format": {
      "cache": false
    }
  }
}
```

## Shared Package Example: @mymonorepo/types

```
packages/types/
├── package.json
├── src/
│   ├── index.ts
│   ├── user.ts
│   └── api.ts
└── tsconfig.json
```

```json
{
  "name": "@mymonorepo/types",
  "version": "1.0.0",
  "private": true,
  "main": "./dist/index.js",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": "./dist/index.js"
  },
  "scripts": {
    "build": "tsc",
    "dev": "tsc --watch"
  },
  "devDependencies": {
    "typescript": "workspace:*"
  }
}
```

```typescript
// packages/types/src/user.ts
export interface User {
  id: string;
  email: string;
  name: string;
  createdAt: Date;
}

export interface UserCreateInput {
  email: string;
  password: string;
  name: string;
}

export interface UserResponse extends User {
  // Exclude password from API responses
}
```

## Using Shared Packages

```json
{
  "name": "@mymonorepo/web",
  "version": "1.0.0",
  "dependencies": {
    "@mymonorepo/types": "workspace:*",
    "@mymonorepo/ui": "workspace:*",
    "@mymonorepo/utils": "workspace:*",
    "react": "^18.0.0",
    "next": "^14.0.0"
  }
}
```

```typescript
// apps/web/src/pages/users.tsx
import type { User } from "@mymonorepo/types";
import { Button } from "@mymonorepo/ui";
import { formatDate } from "@mymonorepo/utils";

export default function Users({ users }: { users: User[] }) {
  return (
    <div>
      {users.map(user => (
        <div key={user.id}>
          <h2>{user.name}</h2>
          <p>Joined: {formatDate(user.createdAt)}</p>
          <Button>Contact</Button>
        </div>
      ))}
    </div>
  );
}
```

## Shared UI Components Package

```
packages/ui/
├── package.json
├── tsconfig.json
└── src/
    ├── index.ts
    ├── Button/
    │   ├── Button.tsx
    │   ├── Button.stories.tsx
    │   └── Button.test.tsx
    ├── Input/
    ├── Card/
    └── ...
```

```typescript
// packages/ui/src/Button/Button.tsx
import React from "react";
import styles from "./Button.module.css";

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: "primary" | "secondary" | "danger";
  size?: "sm" | "md" | "lg";
  loading?: boolean;
}

export const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ variant = "primary", size = "md", loading, children, ...props }, ref) => {
    return (
      <button
        ref={ref}
        className={`${styles.button} ${styles[variant]} ${styles[size]}`}
        disabled={loading}
        {...props}
      >
        {loading ? "Loading..." : children}
      </button>
    );
  }
);

Button.displayName = "Button";
```

## Shared Configuration Package

```
packages/config/
├── eslint-config/
│   ├── index.js
│   ├── nextjs.js
│   └── react.js
├── prettier-config/
│   └── index.js
├── tsconfig/
│   ├── base.json
│   ├── react.json
│   └── node.json
└── package.json
```

```javascript
// packages/config/eslint-config/nextjs.js
module.exports = {
  extends: ["next", "turbo"],
  rules: {
    "@next/next/no-html-link-for-pages": "off",
    "react/jsx-key": "off"
  },
  parserOptions: {
    babelOptions: {
      presets: ["next/babel"]
    }
  }
};

// Usage in apps/web/.eslintrc.js
module.exports = {
  extends: ["@mymonorepo/config/eslint-config/nextjs"]
};
```

## Shared TypeScript Config

```json
{
  "name": "@mymonorepo/tsconfig",
  "version": "1.0.0",
  "private": true,
  "files": ["tsconfig.json", "base.json", "react.json", "node.json"]
}
```

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "lib": ["ES2020"],
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "moduleResolution": "bundler"
  }
}
```

## Dependency Management Best Practices

```json
{
  "name": "apps/web",
  "dependencies": {
    "@mymonorepo/types": "workspace:*",
    "react": "^18.0.0",
    "next": "^14.0.0"
  },
  "devDependencies": {
    "@mymonorepo/config": "workspace:*",
    "typescript": "workspace:*",
    "eslint": "workspace:*"
  }
}
```

**Rules:**
- ✅ Use `workspace:*` for internal packages
- ✅ Pin versions for external packages
- ❌ NEVER: Mixed workspace/npm package versions
- ✅ Use `pnpm up` to update all packages
- ✅ Use `pnpm list --depth=0` to check duplicates

## Running Commands Across Packages

```bash
# Run script in all packages
pnpm --recursive run build

# Run in specific package
pnpm -F @mymonorepo/web run dev

# Run in package and dependencies
pnpm -F @mymonorepo/web --recursive run build

# Run in changed packages only
turbo run build --filter='[HEAD~1]'

# Run only in apps
turbo run build --scope='./apps/*'
```

## CI/CD Pipeline (GitHub Actions)

```yaml
name: CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0  # For better change detection
      
      - uses: pnpm/action-setup@v2
        with:
          version: 9
      
      - uses: actions/setup-node@v3
        with:
          node-version: "20"
          cache: "pnpm"
      
      - name: Install dependencies
        run: pnpm install
      
      - name: Lint
        run: turbo lint
      
      - name: Build
        run: turbo build
      
      - name: Test
        run: turbo test
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3

  deploy:
    needs: build
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    
    steps:
      - uses: actions/checkout@v3
      - uses: pnpm/action-setup@v2
      - uses: actions/setup-node@v3
        with:
          node-version: "20"
          cache: "pnpm"
      
      - name: Install & build
        run: pnpm install && turbo build
      
      - name: Deploy web
        run: pnpm -F @mymonorepo/web run deploy
      
      - name: Deploy API
        run: pnpm -F @mymonorepo/api run deploy
```

## Local Development Workflow

```bash
# Clone and setup
git clone https://github.com/user/monorepo.git
cd monorepo
pnpm install

# Development
pnpm run dev       # Runs all dev servers

# Terminal 1: Web dev server
pnpm -F @mymonorepo/web run dev

# Terminal 2: API dev server  
pnpm -F @mymonorepo/api run dev

# Build everything
pnpm run build

# Test everything
pnpm run test

# Lint everything
pnpm run lint

# Clean build artifacts
pnpm run clean
```

## Monorepo Tools Comparison

| Tool | Caching | Task Orchestration | Lock File | Package Manager |
|------|---------|-------------------|-----------|-----------------|
| **Turborepo** | ✅ Yes | ✅ Excellent | Via npm/pnpm | Any |
| **Nx** | ✅ Yes | ✅ Excellent | Via npm/pnpm | Any |
| **Lerna** | ❌ No | ⚠️ Basic | Via npm/pnpm | npm/yarn |
| **Rush** | ✅ Yes | ✅ Good | Proprietary | npm/yarn |
| **pnpm workspaces** | ❌ No | ❌ No | ✅ pnpm | pnpm |

**Recommendation:** Turborepo + pnpm for best experience

## Best Practices Checklist

- ✅ Use workspace protocol (`workspace:*`)
- ✅ Define clear package boundaries
- ✅ Shared configs in dedicated packages
- ✅ Use Turborepo for task orchestration
- ✅ Implement proper caching strategy
- ✅ Use CI/CD with change detection
- ✅ Document public APIs of shared packages
- ✅ Use semantic versioning for releases
- ✅ Implement dependency constraints
- ✅ Regular cleanup of unused packages
- ✅ Use private scope for internal packages
- ✅ Document folder structure

## Keywords
monorepo, turborepo, pnpm, workspaces, shared-packages, multi-package, scaling, ci-cd
