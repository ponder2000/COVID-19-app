
final String url = 'https://api.covid19api.com/summary';

int getDeaths(data, int index) {
  return data[index]['TotalDeaths'];
}

int getRecovers(data, int index) {
  return data[index]['TotalRecovered'];
}

int getConfirms(data, int index) {
  return data[index]['TotalConfirmed'];
}

int getNewDeath(data, int index) {
  return data[index]['NewDeaths'];
}

int getNewRecovers(data, int index) {
  return data[index]['NewRecovered'];
}

int getNewConfirms(data, int index) {
  return data[index]['NewConfirmed'];
}
