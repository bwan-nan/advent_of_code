/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   2_day5.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/24 11:42:36 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/24 11:54:13 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../libft/libft.h"
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

static char	*get_polymer(char *str, char letter)
{
	int	i;
	int	j;
	int	str_len;
	int	polymer_len;
	char	*polymer;

	str_len = ft_strlen(str);
	polymer_len = str_len;
	i = 0;
	while (i < str_len)
	{
		if (str[i] == letter || str[i] == letter - 32)
			polymer_len--;
		i++;
	}
	if (!(polymer = malloc(sizeof(char) * polymer_len)))
		return (NULL);
	i = 0;
	j = 0;
	while (str[i])
	{
		while (str[i] == letter || str[i] == letter - 32)
			i++;
		polymer[j] = str[i];
		j++;
		i++;
	}
	polymer[j] = '\0';
	return (polymer);
}

static int	make_reactions(char **str)
{
	int	i;
	int	j;
	int	k;
	char	*tmp;
	int	len;

	i = 0;
	tmp = *str;
	len = ft_strlen(tmp);
	while (i < len - 1)
	{
		if ((tmp[i] >= 97 && tmp[i] <= 122 && tmp[i + 1] == tmp[i] - 32)
				|| (tmp[i] >= 65 && tmp[i] <= 90 && tmp[i + 1] == tmp[i] + 32))
		{
			if (!(*str = malloc(sizeof(char) * (len - 2))))
				return (-1);
			j = 0;
			k = 0;
			while (tmp[j] && j < len)
			{
				if (j == i)
					j += 2;
				(*str)[k] = tmp[j];
				j++;
				k++;
			}
			(*str)[k] = '\0';
			//ft_strdel(&tmp);
			/** did not manage to free properly **/
			return (1);
		}
		i++;
	}
	return (0);
}

static void	read_input(char *input, char **str)
{
	int	fd;
	char	*line;

	line = NULL;
	fd = open(input, O_RDONLY);
	while (get_next_line(fd, &line))
	{
		if (!(*str = malloc(sizeof(char) * ft_strlen(line))))
			return ;
		*str = ft_strdup(line);
		ft_strdel(&line);
	}
	close(fd);
}

int		main(int ac, char **av)
{
	char	*str;
	int	i;
	char	letter;
	int	minimum_len;
	int	fully_reacted_len;
	char	*polymer;

	str = NULL;
	polymer = NULL;
	i = 0;
	if (ac == 2)
	{
		read_input(av[1], &str);
		while (make_reactions(&str))
			i++;
		minimum_len = ft_strlen(str);
		letter = 97;
		while (letter <= 122)
		{
			polymer = get_polymer(str, letter);
			i = 0;
			while (make_reactions(&polymer))
				i++;
			fully_reacted_len = ft_strlen(polymer);
			if (fully_reacted_len < minimum_len)
				minimum_len = fully_reacted_len;
			ft_strdel(&polymer);
			letter++;
		}
		ft_putnbr(minimum_len);
		ft_putchar('\n');
	}
	return (0);
}
