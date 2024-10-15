final class APIConstant {
  static const baseURL = "https://api.themoviedb.org";
  static const topRatedMoviePath = "/3/movie/top_rated";
  static const upcomingMoviePath = "/3/movie/upcoming";
  static const movieSearchPath = "/3/search/movie";
  static String movieDetails(String id) => "/3/movie/$id";
  static String addFavorites(String accountId) =>
      "/3/account/$accountId/favorite";
  static String getFavorites(String accountId) =>
      "/3/account/$accountId/favorite/movies";
}
