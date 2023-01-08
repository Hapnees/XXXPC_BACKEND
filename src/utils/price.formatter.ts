export const priceFormat = (prices: number[]) => {
  // Форматируем цены
  if (prices.length === 1) return prices

  const min = Math.min(...prices)
  const max = Math.max(...prices)

  if (min === max) return [min]

  return [min, max]
}
