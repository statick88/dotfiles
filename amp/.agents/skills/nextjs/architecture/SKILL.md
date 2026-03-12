---
name: nextjs-architecture
description: >
  Next.js architecture: Scope Rule, project structure, file naming, App Router patterns.
  Trigger: When structuring Next.js projects or deciding where to place components.
metadata:
  author: gentleman-programming
  version: "1.0"
---

## The Scope Rule (REQUIRED)

**"Scope determines structure"** - Where a component lives depends on its usage.

| Usage | Placement |
|-------|-----------|
| Used by 1 feature | `features/[feature]/` |
| Used by 2+ features | `features/shared/` |

### Example

```
src/
  features/
    (auth)/
      login/
        page.tsx
        components/     # Used ONLY by login
      register/
        page.tsx
        components/     # Used ONLY by register
      components/       # Used by login AND register
    (shop)/
      products/
        page.tsx
        components/     # Used ONLY by products
      cart/
        page.tsx
        components/     # Used ONLY by cart
      components/       # Used by products AND cart
    shared/
      components/       # Used by 2+ features
```

---

## Project Structure (App Router)

```
src/
  app/
    (auth)/
      login/
        page.tsx
        layout.tsx      # Auth-specific layout
      register/
        page.tsx
    (shop)/
      products/
        page.tsx
        loading.tsx
        error.tsx
      cart/
        page.tsx
      _components/      # Feature-specific components
    api/                # API routes
    globals.css
    layout.tsx          # Root layout
    not-found.tsx
  features/
    [feature-name]/
      components/       # Feature-specific components
      hooks/            # Feature-specific hooks
      types/            # Feature-specific types
      utils/            # Feature-specific utilities
  shared/
    components/         # Global components (2+ features)
    hooks/              # Global hooks
    types/              # Global types
    utils/              # Global utilities
    lib/                # Global configurations
  core/
    services/           # App-wide services
    config/             # App configuration
```

### Route Groups with Parenthesis

- `(auth)` - Authentication feature
- `(shop)` - E-commerce feature
- `(dashboard)` - Admin area

---

## File Naming (REQUIRED)

- React components: `.tsx` (not `.component.tsx`)
- Page files: `page.tsx`
- Layout files: `layout.tsx`
- API routes: `route.ts`

```
✅ products/page.tsx
❌ products/ProductsPage.tsx

✅ cart/components/cart-item.tsx
❌ cart/components/CartItemComponent.tsx

✅ hooks/use-cart.ts
❌ hooks/useCartHook.ts
```

---

## Component Types

### Server Components (Default)

```tsx
// products/page.tsx
import { ProductList } from '@/features/shared/components/product-list';
import { getProducts } from '@/features/shop/products/utils';

export default async function ProductsPage() {
  const products = await getProducts();
  return <ProductList products={products} />;
}
```

### Client Components (When Needed)

```tsx
'use client';

import { useState } from 'react';

export function AddToCartButton({ product }: { product: Product }) {
  const [loading, setLoading] = useState(false);
  
  return (
    <button onClick={() => handleAdd(product)} disabled={loading}>
      {loading ? 'Adding...' : 'Add to Cart'}
    </button>
  );
}
```

Use `'use client'` when:
- Using hooks (`useState`, `useEffect`, etc.)
- Event handlers (`onClick`, `onSubmit`)
- Browser-only APIs
- Interactivity

---

## Server Actions

```tsx
// features/shop/cart/actions.ts
'use server';

export async function addToCart(productId: string) {
  // Server-side logic
  await db.cart.create({ productId });
  revalidatePath('/cart');
}

export async function removeFromCart(itemId: string) {
  await db.cart.delete({ where: { id: itemId } });
  revalidatePath('/cart');
}
```

---

## Data Fetching

```tsx
// Parallel fetching with Suspense
import { Suspense } from 'react';
import { ProductGrid } from './product-grid';
import { RecommendedProducts } from './recommended';

export default async function ProductPage({ params }: Props) {
  return (
    <main>
      <Suspense fallback={<ProductSkeleton />}>
        <ProductGrid />
      </Suspense>
      <Suspense fallback={<RecommendedSkeleton />}>
        <RecommendedProducts />
      </Suspense>
    </main>
  );
}

// Sequential with await
export async function ProductGrid() {
  const products = await fetchProducts();
  const categories = await fetchCategories();
  // Use both
}
```

---

## Co-location Pattern

Keep related files together. Use private folders sparingly.

```
features/
  products/
    page.tsx              # Route
    _components/          # Private (only this route)
      product-card.tsx
      product-grid.tsx
    types/                # Feature-specific
      product.ts
    utils/                # Feature-specific
      formatters.ts
```

---

## Imports Organization

```tsx
// External → Shared → Feature → Relative
import { useState } from 'react';
import { Button } from '@/shared/components/button';
import { formatPrice } from '@/shared/utils';
import { ProductCard } from '../components/product-card';
import styles from './styles.module.css';
```

---

## Commands

```bash
# New project
npx create-next-app@latest my-app --typescript --tailwind --app

# Generate component
npx shadcn@latest add button card

# Type generation
npx supabase gen types typescript --project-id xxx > types/database.types.ts
```

---

## Resources

- https://nextjs.org/docs
- https://nextjs.org/docs/app/building-your-application/routing
