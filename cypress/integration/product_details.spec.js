describe("jungle app", () => {
  beforeEach(() => {
    cy.visit("http://0.0.0.0:3000");
  });

  it("should redirect to product page after clicking on a product", () => {
    cy.get(".products article").first().click();
    cy.url().should("include", "/products/");
  });
});