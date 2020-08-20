require 'test_helper'
include ERB::Util

class RecipesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    VCR.use_cassette("recipes") do
      get root_url
    end
    assert_response :success
  end

  test "index should display recipe titles and images" do
    VCR.use_cassette("recipes") do
      get root_url
    end
    assert_includes @response.body, html_escape("Grilled Steak & Vegetables with Cilantro-Jalapeño Dressing")
    assert_includes @response.body, html_escape("Tofu Saag Paneer with Buttery Toasted Pita")
    assert_includes @response.body, html_escape("//images.ctfassets.net/kk2bw5ojx476/5mFyTozvSoyE0Mqseoos86/fb88f4302cfd184492e548cde11a2555/SKU1479_Hero_077-71d8a07ff8e79abcb0e6c0ebf0f3b69c.jpg")
    assert_includes @response.body, html_escape("//images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg")
  end

  test "show view should display all recipe details" do
    VCR.use_cassette("recipe_one") do
      get recipe_url('5jy9hcMeEgQ4maKGqIOYW6')
    end
    assert_includes @response.body, "Tofu Saag Paneer with Buttery Toasted Pita"
    assert_includes @response.body, html_escape("//images.ctfassets.net/kk2bw5ojx476/48S44TRZN626y4Wy4CuOmA/9c0a510bc3d18dda9318c6bf49fac327/SKU1498_Hero_154__2_-adb6124909b48c69f869afecb78b6808-2.jpg")
    assert_includes @response.body, html_escape('Saag paneer is a popular Indian dish with iron-rich spinach and cubes of paneer, an Indian cheese that is firm enough to retain it\'s shape, but silky-soft on the inside. We have reimagined Saag Paneer and replaced the "paneer" with crispy cubes of firm tofu, making this already delicious and nutritious vegetarian dish burst with protein. Toasted pita bread is served alongside as an ode to naan. Cook, relax, and enjoy!')
  end

  test "show view should display recipe chef" do
    VCR.use_cassette("recipe_with_chef") do
      get recipe_url('2E8bc3VcJmA8OgmQsageas')
    end
    assert_includes @response.body, "Mark Zucchiniberg"
  end

  test "show view should display recipe tags" do
    VCR.use_cassette("recipe_with_tags") do
      get recipe_url('437eO3ORCME46i02SeCW46')
    end
    assert_includes @response.body, "healthy"
    assert_includes @response.body, "gluten free"
  end

  test "show view should have a back link" do
    VCR.use_cassette("recipe_one") do
      get recipe_url('5jy9hcMeEgQ4maKGqIOYW6')
    end
    assert_includes @response.body, html_escape('< Back')
  end
end
