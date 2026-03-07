---
name: astro-architecture
description: >
  Astro architecture: Scope Rule, project structure, file naming, Islands patterns.
  Trigger: When structuring Astro projects or deciding where to place components.
metadata:
  author: gentleman-programming
  version: "1.0"
---

## The Scope Rule (REQUIRED)

**"Scope determines structure"** - Where a component lives depends on its usage.

| Usage | Placement |
|-------|-----------|
| Used by 1 feature | `src/features/[feature]/` |
| Used by 2+ features | `src/shared/` |

### Example

```
src/
  features/
    blog/
      posts/
        page.astro        # Blog posts listing
        [slug]/
          page.astro      # Single post
        components/       # Blog-specific components
      utils/              # Blog-specific utilities
    shop/
      products/
        page.astro        # Products listing
        [id]/
          page.astro      # Single product
        components/       # Shop-specific components
      utils/              # Shop-specific utilities
    shared/
      components/         # Used by 2+ features
        header.astro
        footer.astro
      layouts/            # Global layouts
```

---

## Project Structure

```
src/
  content/
    blog/                 # Content Collections
      posts/
        intro-to-astro.md
        second-post.md
    products/
      product-1.md
  features/
    [feature-name]/
      pages/              # Feature-specific pages
        index.astro
        [slug]/
          page.astro
      components/         # Feature-specific components
      layouts/            # Feature-specific layouts
      utils/              # Feature-specific utilities
      types/              # Feature-specific types
  shared/
    components/           # Global components (Astro or framework)
      ui/
        button.astro
        card.astro
    layouts/              # Global layouts
      base.astro
      blog-post.astro
    pages/                # Global pages
      index.astro
      404.astro
    styles/               # Global styles
    lib/                  # Utilities, configs
  env.d.ts
astro.config.mjs
```

---

## Content Collections (Type-Safe Content)

```typescript
// src/content/config.ts
import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.date(),
    author: z.string(),
    tags: z.array(z.string()),
    image: z.string().optional(),
  }),
});

export const collections = {
  blog,
  products: defineCollection({
    type: 'content',
    schema: z.object({
      name: z.string(),
      price: z.number(),
      description: z.string(),
      image: z.string(),
      category: z.string(),
    }),
  }),
};
```

```typescript
// Using collections
import { getCollection } from 'astro:content';

const posts = await getCollection('blog');
const products = await getCollection('products');
```

---

## File Naming (REQUIRED)

```
✅ src/features/blog/pages/index.astro
❌ src/features/blog/pages/BlogIndexPage.astro

✅ src/shared/components/ui/button.astro
❌ src/shared/components/ui/ButtonComponent.astro

✅ src/content/blog/intro-post.md
❌ src/content/blog/IntroPost.md
```

---

## Component Types

### Astro Components (Static by Default)

```astro
---
// src/shared/components/card.astro
interface Props {
  title: string;
  class?: string;
}

const { title, class: className } = Astro.props;
---

<article class:list={['card', className]}>
  <slot />
</article>

<style>
  .card {
    padding: 1rem;
    border: 1px solid #e5e7eb;
  }
</style>
```

### Framework Components (Islands)

```astro
---
// src/features/shop/cart/cart-button.tsx
import { useState } from 'react';

export function CartButton() {
  const [count, setCount] = useState(0);
  return <button>{count} items</button>;
}
```

```astro
---
// src/features/shop/products/product-grid.astro
import { CartButton } from './cart-button';

<Product client:visible>
  <CartButton client:idle />
</Product>
```

### Hydration Directives

| Directive | When | Use Case |
|-----------|------|----------|
| `client:load` | Immediately | Interactive components on page load |
| `client:idle` | When browser idle | Non-critical interactivity |
| `client:visible` | When in viewport | Lazy load on scroll |
| `client:media` | Based on CSS media | Responsive components |
| `client:only` | Client-side only | Components needing browser APIs |

---

## Islands Architecture

```astro
---
// src/pages/index.astro
import Header from '@/shared/components/header.astro';
import Hero from '@/features/home/components/hero.astro';
import ProductGrid from '@/features/shop/components/product-grid';
import Newsletter from '@/shared/components/newsletter';

<Header />
<Hero />

<!-- Interactive island - loads immediately -->
<ProductGrid client:load />

<!-- Interactive island - loads when idle -->
<Newsletter client:idle />

<!-- Static HTML - no JS -->
<footer />
```

---

## Layouts

```astro
---
// src/shared/layouts/base.astro
import Header from '@/shared/components/header.astro';
import Footer from '@/shared/components/footer.astro';

interface Props {
  title: string;
  description?: string;
}

const { title, description = 'My site' } = Astro.props;
---

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width" />
    <title>{title}</title>
    <meta name="description" content={description} />
  </head>
  <body>
    <Header />
    <main>
      <slot />
    </main>
    <Footer />
  </body>
</html>
```

```astro
---
// src/features/blog/layouts/post.astro
import BaseLayout from '@/shared/layouts/base.astro';

interface Props {
  frontmatter: {
    title: string;
    pubDate: Date;
    author: string;
  };
}

const { frontmatter } = Astro.props;
---

<BaseLayout title={frontmatter.title}>
  <article>
    <header>
      <h1>{frontmatter.title}</h1>
      <time>{frontmatter.pubDate.toLocaleDateString()}</time>
      <span>by {frontmatter.author}</span>
    </header>
    <slot />
  </article>
</BaseLayout>
```

---

## Routing

### File-based Routing

```
src/pages/
  index.astro              # /
  about.astro              # /about
  blog/
    index.astro            # /blog
    [slug].astro           # /blog/:slug
  products/
    [category]/
      index.astro          # /products/:category
      [id].astro           # /products/:category/:id
```

### Dynamic Routes

```astro
---
// src/pages/blog/[slug].astro
import { getCollection } from 'astro:content';
import PostLayout from '../../features/blog/layouts/post.astro';

export async function getStaticPaths() {
  const posts = await getCollection('blog');
  return posts.map(post => ({
    params: { slug: post.slug },
    props: { post },
  }));
}

const { post } = Astro.props;
const { Content } = await post.render();
---

<PostLayout frontmatter={post.data}>
  <Content />
</PostLayout>
```

---

## Imports Organization

```astro
---
// External → Shared → Feature → Relative
import { useState } from 'react';
import BaseLayout from '@/shared/layouts/base.astro';
import { formatDate } from '@/shared/utils';
import ProductCard from '../../components/product-card';
import styles from './styles.module.css';
---
```

---

## Commands

```bash
# New project
npm create astro@latest my-site

# Add integrations
npx astro add react tailwind

# Generate types from schema
npx astro sync

# Development
npm run dev
```

---

## Best Practices

1. **Static by default** - Use `.astro` components
2. **Islands sparingly** - Only hydrate what's needed
3. **Content Collections** - Use for all content
4. **Scoped styles** - Keep styles with components
5. **No .astro.ts** files - Separate logic and markup

---

## Resources

- https://docs.astro.build
- https://docs.astro.build/concepts/islands
- https://docs.astro.build/content-collections
