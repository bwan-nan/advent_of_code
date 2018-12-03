/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strstr.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/11/07 17:53:57 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/11/20 13:39:19 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

char	*ft_strstr(const char *haystack, const char *needle)
{
	int		i;
	int		j;
	int		k;
	char	*str;

	i = 0;
	j = 0;
	str = (char *)haystack;
	if (ft_strlen(needle) == 0)
		return (str);
	while (needle[j])
		j++;
	while (str[i])
	{
		if (str[i] == needle[0])
		{
			k = 0;
			while (k < j && (str[i + k] == needle[k]))
				k++;
			if (k == j)
				return ((str + i));
		}
		i++;
	}
	return (0);
}
