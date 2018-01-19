const getProperty = function(object, propertyName) {
  let parts = propertyName.split(".");
  let length = parts.length;
  let property = object;

  for (let i = 0; i < length; i++) {
    property = property[parts[i]];
  };

  return property;
};

export default getProperty;

