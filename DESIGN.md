# Design System Strategy: The Intelligent Surface

## 1. Overview & Creative North Star
The Creative North Star for this design system is **"The Digital Fiduciary."** 

In an era of "black box" AI, this system aims to feel transparent, authoritative, and impossibly refined. We are moving away from the cluttered, "gadgety" look of traditional fintech. Instead, we embrace **Editorial Precision**. By utilizing intentional asymmetry, expansive negative space, and a sophisticated layering of monochromatic surfaces, we create an environment where data feels like a high-end publication rather than a spreadsheet. The AI influence is felt through "living" surfaces—containers that seem to breathe and react through subtle glassmorphism and soft tonal shifts—rather than glowing circuits or sci-fi tropes.

## 2. Colors: The Tonal Architecture
We utilize a high-contrast palette where the deep navy provides the "weight" of a legacy bank, while the secondary teal provides the "pulse" of modern technology.

### The "No-Line" Rule
To achieve a premium, seamless feel, **1px solid borders are strictly prohibited** for sectioning. Contrast and containment must be achieved exclusively through background color shifts. 
*   *Example:* Place a `surface-container-low` (#f2f4f7) card on a `surface` (#f7f9fc) background. The change in hex value is the border.

### Surface Hierarchy & Nesting
Treat the UI as a physical stack of semi-translucent materials. 
*   **Base:** `background` (#f7f9fc)
*   **Layer 1:** `surface-container-low` (#f2f4f7) for large structural groupings.
*   **Layer 2 (Focus):** `surface-container-lowest` (#ffffff) for the highest level of interaction, like a primary transaction card.
*   **Nesting:** When placing an element inside a card, do not use a line; use a `surface-variant` (#e0e3e6) to "inset" the content.

### Signature Textures & Glassmorphism
For floating action buttons or high-level AI insights, use **Glassmorphism**. Apply `on_surface` at 5% opacity with a `20px` backdrop blur. For primary CTAs, use a subtle linear gradient from `primary` (#000f22) to `primary_container` (#0a2540) at a 135° angle to add "soul" and depth.

## 3. Typography: The Editorial Voice
We use **Inter** as our sole typeface to maintain a clean, Swiss-inspired modernist aesthetic.

*   **Display (Display-LG to SM):** Reserved for high-impact data points (e.g., account balances). Set with `-2%` letter spacing and `Bold` weight.
*   **Headlines (Headline-LG to SM):** The "Editorial" voice. Use `headline-md` (1.75rem) for screen titles to convey authority.
*   **Body (Body-LG to SM):** Use `body-md` (0.875rem) for most text. Maintain a generous line height (1.5x) to prevent "data fatigue."
*   **Labels (Label-MD to SM):** Used for micro-copy and badges. Always `Medium` weight, uppercase with `5%` letter spacing for a "Pro" utility feel.

## 4. Elevation & Depth: Tonal Layering
Traditional drop shadows are often messy. This system relies on **Ambient Light Physics**.

*   **The Layering Principle:** Use the spacing scale `2` (0.5rem) or `3` (0.75rem) between surface tiers to create natural separation.
*   **Ambient Shadows:** For "floating" elements (like a bottom sheet or a modal), use a dual-shadow approach:
    *   *Shadow 1:* 0px 4px 20px rgba(10, 37, 64, 0.04)
    *   *Shadow 2:* 0px 2px 8px rgba(10, 37, 64, 0.02)
    *   *Note:* The shadow color is a tint of `primary_container`, never pure black.
*   **The Ghost Border Fallback:** If a layout requires a boundary for accessibility (e.g., in a high-glare environment), use `outline-variant` (#c4c6ce) at **15% opacity**. It should be felt, not seen.

## 5. Components

### Buttons
*   **Primary:** `primary` background, `on_primary` text. `xl` (1.5rem) corner radius. 
*   **Secondary:** `secondary_container` background, `on_secondary_container` text.
*   **Ghost:** Transparent background, `primary` text. No border.

### Cards & Lists
*   **Strict Rule:** No dividers. Use `Spacing-4` (1rem) of vertical white space or a shift to `surface-container-high` (#e6e8eb) to indicate a new list item.
*   **Radius:** All cards must use `lg` (1rem / 16px) roundedness to maintain the "Soft Minimal" identity.

### Status Badges & Chips
*   **AI Insight Chip:** Use a `surface-container-highest` background with a 1px "Ghost Border" at 20% opacity. 
*   **Status Badges:** Use `success_green` or `error_red` at 10% opacity for the background, with the 100% opaque color for the text.

### Input Fields
*   **State:** Default state is `surface-container-lowest` with a subtle `outline-variant` at 20%. 
*   **Focus:** Transition the border to `secondary` (#006b5c) and add a 4px soft outer glow of the same color at 10% opacity.

### AI Feedback Component (System Specific)
A custom component for "TrustLens AI" analysis. A `surface-container-lowest` card with a left-accent "glow" bar (2px width) using a gradient of `secondary` to `primary_fixed_dim`. This signals "Active AI Thought" without using distracting animations.

## 6. Do’s and Don’ts

### Do
*   **Do** use asymmetrical margins. A larger top margin (e.g., `Spacing-12`) for headers creates a premium, airy feel.
*   **Do** use `secondary_fixed_dim` (#44ddc2) for iconography to draw the eye to interactive elements.
*   **Do** prioritize "Tonal Contrast" over "Line Contrast."

### Don’t
*   **Don't** use pure black (#000000) for shadows or text. Use `on_surface` (#191c1e).
*   **Don't** use 1px dividers to separate list items; it creates "visual noise" that breaks the premium feel.
*   **Don't** use standard "out-of-the-box" blue. Always stick to the `primary` Deep Navy to maintain the "Trustworthy" brand promise.