/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_split_whitespaces.c                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/09/17 16:56:31 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/09/18 00:42:58 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>

void    ft_show_tab(char **tab);

int		count_words(char *str)
{
	int i;
	int num_words;
	int len;

	i = 0;
	num_words = 0;
	len = 0;
	while (str[i])
	{
		if (str[i] < 33)
			len = 0;
		else if (++len == 1)
			num_words++;
		i++;
	}
	return (num_words);
}

void	ft_fill_tab(char *tab, char *str, int l_count)
{
	int i;
	int j;

	i = 0;
	j = 0;
	while (j < l_count)
	{
		tab[j] = str[i];
		i++;
		j++;
	}
	tab[j] = '\0';
}

char	*ft_create_tab(char *str, int n)
{
	int		i;
	int		k;
	int		l_count;
	char	*tab;

	i = 0;
	k = 0;
	while (str[i])
	{
		l_count = 0;
		while (str[i] < 33)
			i++;
		while (!(str[i] < 33))
		{
			l_count++;
			i++;
		}
		k++;
		if (k == n)
		{
			tab = malloc(sizeof(char) * (l_count + 1));
			ft_fill_tab(tab, (str + i - l_count), l_count);
		}
	}
	return (tab);
}

char	**ft_split_whitespaces(char *str)
{
	int		j;
	int		num_words;
	char	**tab;

	j = 0;
	num_words = count_words(str);
	if (!(tab = malloc(sizeof(char*) * (num_words + 1))))
		return (0);
	while (j < num_words)
	{
		tab[j] = ft_create_tab(str, (j + 1));
		j++;
	}
	tab[j] = 0;
	return (tab);
}
