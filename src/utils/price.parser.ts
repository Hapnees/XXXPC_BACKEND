export const priceParser = (price: string) => {
  return parseInt(price.split(' ')[0])
}
