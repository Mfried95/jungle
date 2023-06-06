describe("jungle app", () => {
  beforeEach(() => {
    cy.visit("http://0.0.0.0:3000");
  });

  it("should increase cart count by one when user click 'Add to Cart' button", () => {
    cy.get(".btn")
      .contains("Add")
      .first()
      .scrollIntoView()
      .click({ force: true });

    cy.get(".nav-link").contains("1");
  });
});