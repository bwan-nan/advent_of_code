/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   2_day3.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/17 18:39:16 by bwan-nan          #+#    #+#             */
/*   Updated: 2019/01/11 14:00:39 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"
#include "day3.h"
#include <stdlib.h>
#include <unistd.h>

void			del_claims_list(t_claim *claims_list)
{
	t_claim *tmp;
	if (claims_list)
	{
		while (claims_list)
		{
			tmp = claims_list->next;
			free(claims_list);
			claims_list = tmp;
		}
	}
	(void)claims_list;
}

int			find_the_one(t_claim *claims_list, char **map)
{
	t_claim *elem;
	int	i;
	int	j;
	int	count;
	
	elem = claims_list;
	while (elem)
	{
		count = 0;
		j = 0;
		while (j < elem->height)
		{
			i = 0;
			while (i < elem->width)
			{
				if (map[elem->y_offset + j][elem->x_offset + i] == 'X')
					count++;
				i++;
			}
			j++;
		}
		if (count == 0)
			return (elem->claim_number);
		elem = elem->next;
	}
	return (0);

}

static t_claim		*create_claim(char *line)
{
	t_claim	*new_claim;

	if (!(new_claim = (t_claim *)malloc(sizeof(t_claim))))
		return (NULL);
	new_claim->claim_number = ft_atoi(ft_strchr(line, '#') + 1);
	new_claim->x_offset = ft_atoi(ft_strchr(line, '@') + 1);
	new_claim->y_offset = ft_atoi(ft_strchr(line, ',') + 1);
	new_claim->width = ft_atoi(ft_strchr(line, ':') + 1);
	new_claim->height = ft_atoi(ft_strchr(line, 'x') + 1);
	new_claim->next = NULL;
	return (new_claim);
}

void			load_claim(t_claim **claims_list, char *line)
{
	t_claim *tmp;

	if (*claims_list == NULL)
		*claims_list = create_claim(line);
	else
	{
		tmp = *claims_list;
		while (tmp->next)
			tmp = tmp->next;
		tmp->next = create_claim(line);
	}
}
