SELECT
  p.id,
  p.name,
  c.name AS category_name,
  p.status,
  p.price,
  p.updated_at
FROM public.products p
LEFT JOIN public.categories c ON c.id = p.category_id
ORDER BY p.updated_at DESC
