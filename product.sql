SELECT p.productid, p.name, p.description, p.price, p.image, p.categoryid, c.name AS categoryname
FROM public.product p
JOIN public.category c ON p.categoryid = c.categoryid


