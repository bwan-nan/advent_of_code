/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   1_day7.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/24 12:29:53 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/24 18:30:33 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../libft/libft.h"
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

static void	load_instructions(t_pre **instructions, line)
{

}

static void	read_input(char *input, t_inst *instructions)
{
	int	fd;
	char	*line;

	line = NULL;
	fd = open(input, O_RDONLY);
	while (get_next_line(fd, &line))
	{
		load_instructions(&instructions, line);
		ft_strdel(&line);
	}
}

int		main(int ac, char **av)
{
	t_inst	*instructions;

	instructions = NULL;
	if (ac == 2)
	{
		read_input(av[1], instructions);
	}
	return (0);
}
