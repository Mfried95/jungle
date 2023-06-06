// Write a basic test to visit the home page of our Jungle App.

describe("jungle app", () => {
  beforeEach(() => {
    cy.visit("http://0.0.0.0:3000");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
});

