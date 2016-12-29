create or replace PROCEDURE FINAL2(prodId IN char) AS 
BEGIN
    DELETE 
    from products 
    WHERE products.code = prodId;
    END FINAL2;